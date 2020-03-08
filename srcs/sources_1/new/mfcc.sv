`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 10:38:39 PM
// Design Name: 
// Module Name: mfcc
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


module mfcc
    #(
//    parameter SAMPLE_RATE = 20000,
//    parameter clk_f = 200000000,

    parameter N = 512,          // Must be power of 2. Replace shift registers in hamming and filter_bank with python generated line when N is not 512
    parameter STRIDE = 256,     // Must be power of 2
    parameter OUT_WIDTH = 1     // Must be between 1 and 40
    )(
    input clk,
    input reset,
    input [15:0] s_axis_tdata,
    output [15:0] m_axis_tdata[OUT_WIDTH],
    
    output s_axis_tready,
    input s_axis_tvalid,
    
    input m_axis_tready,
    output m_axis_tvalid,
    output m_axis_tlast
    );
    
    logic [15:0]q_hamming_input;
    logic [15:0]d_hamming_input;
    logic [15:0]q_power_spec_input;
    logic [15:0]d_power_spec_input;
    logic [31:0]d_filter_bank_input;
    logic [31:0]q_filter_bank_input;
    logic [15:0]filter_bank_output[40];
    
    logic pow_spec_ready;
    logic q_frame_valid;
    logic qq_frame_valid;
    logic d_frame_valid;
    logic filt_bank_ready;
    logic d_pow_spec_valid;
    logic q_pow_spec_valid;
//    logic pow_spec_last;
    logic reshape_ready;
    logic filt_bank_valid;
    
    prepare_input #(.N(N),
                    .STRIDE(STRIDE)) my_in
                                           (.clk(clk),
                                            .reset(reset),
                                            .in(s_axis_tdata),
                                            .out(d_hamming_input),
                                            .s_ready(s_axis_tready),
                                            .s_valid(s_axis_tvalid),
                                            .m_ready(pow_spec_ready),
                                            .m_valid(d_frame_valid));
    
    hamming#(.N(N)) my_hamming
                                        (.clk(clk),
                                         .reset(reset),
                                         .in(q_hamming_input),
                                         .out(d_power_spec_input),
                                         .on(q_frame_valid & pow_spec_ready)
                                         );
                       
    power_spectrum#(.N(N)) my_pow_spec
                                       (.clk(clk),
                                        .reset(reset),
                                        .in(q_power_spec_input),
                                        .out(d_filter_bank_input),
                                        .s_ready(pow_spec_ready),
                                        .s_valid(qq_frame_valid),
//                                        .s_last(s_last),
                                        .m_ready(filt_bank_ready),
                                        .m_valid(d_pow_spec_valid)
//                                        .m_last(pow_spec_last)
                                        );
                                  
    filter_bank#(.N(N/2)) my_filt_bank
                                             (.clk(clk),
                                              .reset(reset),
                                              .in(q_filter_bank_input),
                                              .out(filter_bank_output),
                                              .s_ready(filt_bank_ready),
                                              .s_valid(q_pow_spec_valid),
                                              .m_ready(reshape_ready),
                                              .m_valid(filt_bank_valid)
                                              );
    
    // filter bank output is already 40 wide                                          
    if(OUT_WIDTH != 40) begin
        reshape_output#(.OUT_WIDTH(OUT_WIDTH)) my_out(.clk(clk),
                                                      .reset(reset),
                                                      .in(filter_bank_output),
                                                      .out(m_axis_tdata),
                                                      .s_ready(reshape_ready),
                                                      .s_valid(filt_bank_valid),
                                                      .m_ready(m_axis_tready),
                                                      .m_valid(m_axis_tvalid),
                                                      .m_last(m_axis_tlast));
    end
    else begin
        assign m_axis_tdata = filter_bank_output;
        assign reshape_ready = m_axis_tready;
        assign m_axis_tvalid = filt_bank_valid;
        assign m_axis_tlast = filt_bank_valid;
    end
    
    always_ff @(posedge clk) begin
        begin
            if(filt_bank_ready) begin
                q_filter_bank_input <= d_filter_bank_input;
                q_pow_spec_valid <= d_pow_spec_valid;
            end
            if(pow_spec_ready) begin
                q_power_spec_input <= d_power_spec_input;
                q_hamming_input <= d_hamming_input;
            end
            q_frame_valid <= d_frame_valid;
            qq_frame_valid <= q_frame_valid;
        end
    end
endmodule
