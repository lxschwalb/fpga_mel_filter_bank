`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 12:19:58 AM
// Design Name: 
// Module Name: power_spectrum
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module power_spectrum #(parameter int N=512)(
    input clk,
    input reset,
    input [15:0] in,
    output [31:0] out,
    
    output s_ready,
    input s_valid,
    input s_last,
    
    input m_ready,
    output m_valid,
    output m_last
    );
    localparam LOG2_N = $clog2(N);
    localparam mult_pipelines = 7;
    
    // fft config
//    logic [4:0] nfft = 4'b0110;
//    logic fwd_inv = 1;
//    logic scale_sch = 6'b101010;
    
    // fft signals
    logic [15:0]i_re;                   // real input
    logic [15:0]i_im;                   // imaginary input
    logic [31:0]o_re;                   // real output
    logic [31:0]o_im;                   // imaginary output
    logic q_stop_fft = 1'b0;            // signal to stop symmetrical second half of fft being output
    logic d_stop_fft = 1'b0;
    logic fft_reset = 1'b1;             // resets fft for new frame
    logic fft_out_valid;
    logic d_valid;
    logic [mult_pipelines-1:0] q_valid;
    
    logic [63:0] re_squared;
    logic [63:0] im_squared;
    logic [63:0] sum_squared;           // squared sum of magnitude of fft output
    logic [63:0] pow_spec;
    
    logic [LOG2_N-1:0] q_cnt = 0;       // counter that counts up to half the frame length (to cut off second half off fft output)
    logic [LOG2_N-1:0] d_cnt = 0;
    
    assign i_re = in;
    assign i_im = 16'h0000;
    assign sum_squared = re_squared + im_squared;
    assign pow_spec = sum_squared>>LOG2_N;   // power spectrum is (magnitude^2)/n
    
    // Choosing to output pow_spec[31:0] risks overflow, but does not scale down the result.
    // Choosing to output pow_spec[63:32] would not risk overflow, but the result is scaled down
    // Choose anything inbetween for a tradeoff, for example pow_spec[47:16]
    assign out = pow_spec[31:0];
    
    assign m_valid = q_valid[0];
    
//    assign d_re_squared = $signed(o_re)*$signed(o_re);
//    assign d_im_squared = $signed(o_im)*$signed(o_im);
    
    mult_gen_0 mult_re (
      .CLK(clk),  // input wire CLK
      .A(o_re),      // input wire [31 : 0] A
      .B(o_re),      // input wire [31 : 0] B
      .P(re_squared)      // output wire [63 : 0] P
    );
    
    mult_gen_0 mult_im (
      .CLK(clk),  // input wire CLK
      .A(o_im),      // input wire [31 : 0] A
      .B(o_im),      // input wire [31 : 0] B
      .P(im_squared)      // output wire [63 : 0] P
    );

    xfft_512 my_fft (.aclk(clk),
                     .aresetn(fft_reset & !reset),
                     .s_axis_config_tvalid(1'b0),
                     .s_axis_config_tdata(8'd0),
                     .s_axis_data_tdata({i_re, i_im}),
                     .s_axis_data_tvalid(s_valid),
                     .s_axis_data_tready(s_ready),
                     .s_axis_data_tlast(s_last),
                     .m_axis_data_tdata({o_re, o_im}),
                     .m_axis_data_tvalid(fft_out_valid),
                     .m_axis_data_tready(m_ready)
//                     .m_axis_data_tlast(m_last)
                     );

    always_comb begin
        if(q_stop_fft) begin                            // keeps fft reset low for 2nd cycle
            fft_reset = 1'b0;
            d_valid = 1'b0;
            d_cnt = 0;
            d_stop_fft = 1'b0;
        end else begin
            if(q_cnt[LOG2_N-1]) begin                   // detects when to stop fft, sets fft reset low for 1 cycle
                d_valid = 1'b0;
                d_cnt = 0;
                d_stop_fft = 1'b1;
                fft_reset = 1'b0;
            end
            else begin                                  // normal operation
                d_valid = fft_out_valid;
                d_stop_fft = 1'b0; 
                fft_reset = 1'b1;           
                if (m_ready & fft_out_valid)
                    d_cnt = q_cnt + 1'b1;
                else
                    d_cnt = q_cnt;
            end
        end
    end
    
    always_ff @(posedge clk) begin
        q_cnt <= d_cnt;
        q_stop_fft <= d_stop_fft;
        q_valid[mult_pipelines-1] <= d_valid;
        
        for (int i=0; i<mult_pipelines-1; i++)
            q_valid[i] <= q_valid[i+1];
    end
endmodule

