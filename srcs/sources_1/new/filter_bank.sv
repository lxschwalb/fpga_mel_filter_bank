`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 12:19:58 AM
// Design Name: 
// Module Name: filter_bank
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
module filter_bank#(parameter N = 256)(
    input clk,
    input reset,
    input [31:0] in,
    output [15:0] out[40],
    input s_valid,
    output s_ready,
    output m_valid,
    input m_ready
    );
    
    // Replace the line below with the python generated line when a different frame length or sampling frequency is used
    logic[15:0] filt_shift_reg[N] = {16'd32768, 16'd32768, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd10923, 16'd21845, 16'd32768, 16'd16384, 16'd32768, 16'd10923, 16'd21845, 16'd32768, 16'd10923, 16'd21845, 16'd32768, 16'd10923, 16'd21845, 16'd32768, 16'd8192, 16'd16384, 16'd24576, 16'd32768, 16'd10923, 16'd21845, 16'd32768, 16'd8192, 16'd16384, 16'd24576, 16'd32768, 16'd8192, 16'd16384, 16'd24576, 16'd32768, 16'd8192, 16'd16384, 16'd24576, 16'd32768, 16'd6554, 16'd13107, 16'd19661, 16'd26214, 16'd32768, 16'd6554, 16'd13107, 16'd19661, 16'd26214, 16'd32768, 16'd6554, 16'd13107, 16'd19661, 16'd26214, 16'd32768, 16'd5461, 16'd10923, 16'd16384, 16'd21845, 16'd27307, 16'd32768, 16'd5461, 16'd10923, 16'd16384, 16'd21845, 16'd27307, 16'd32768, 16'd4681, 16'd9362, 16'd14043, 16'd18725, 16'd23406, 16'd28087, 16'd32768, 16'd4681, 16'd9362, 16'd14043, 16'd18725, 16'd23406, 16'd28087, 16'd32768, 16'd4681, 16'd9362, 16'd14043, 16'd18725, 16'd23406, 16'd28087, 16'd32768, 16'd4096, 16'd8192, 16'd12288, 16'd16384, 16'd20480, 16'd24576, 16'd28672, 16'd32768, 16'd3641, 16'd7282, 16'd10923, 16'd14564, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd3641, 16'd7282, 16'd10923, 16'd14564, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd3641, 16'd7282, 16'd10923, 16'd14564, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd2979, 16'd5958, 16'd8937, 16'd11916, 16'd14895, 16'd17873, 16'd20852, 16'd23831, 16'd26810, 16'd29789, 16'd32768, 16'd2979, 16'd5958, 16'd8937, 16'd11916, 16'd14895, 16'd17873, 16'd20852, 16'd23831, 16'd26810, 16'd29789, 16'd32768, 16'd2731, 16'd5461, 16'd8192, 16'd10923, 16'd13653, 16'd16384, 16'd19115, 16'd21845, 16'd24576, 16'd27307, 16'd30037, 16'd32768, 16'd2731, 16'd5461, 16'd8192, 16'd10923, 16'd13653, 16'd16384, 16'd19115, 16'd21845, 16'd24576, 16'd27307, 16'd30037, 16'd32768, 16'd2341, 16'd4681, 16'd7022, 16'd9362, 16'd11703, 16'd14043, 16'd16384, 16'd18725, 16'd21065, 16'd23406, 16'd25746, 16'd28087, 16'd30427, 16'd32768, 16'd2341, 16'd4681, 16'd7022, 16'd9362, 16'd11703, 16'd14043, 16'd16384, 16'd18725, 16'd21065, 16'd23406, 16'd25746, 16'd28087, 16'd30427, 16'd32768, 16'd2048, 16'd4096, 16'd6144, 16'd8192, 16'd10240, 16'd12288, 16'd14336, 16'd16384, 16'd18432, 16'd20480, 16'd22528, 16'd24576, 16'd26624, 16'd28672, 16'd30720, 16'd32768, 16'd2048, 16'd4096, 16'd6144, 16'd8192, 16'd10240, 16'd12288, 16'd14336, 16'd16384, 16'd18432, 16'd20480, 16'd22528, 16'd24576, 16'd26624, 16'd28672, 16'd30720, 16'd32768, 16'd1820, 16'd3641, 16'd5461, 16'd7282, 16'd9102, 16'd10923, 16'd12743, 16'd14564, 16'd16384, 16'd18204, 16'd20025, 16'd21845, 16'd23666, 16'd25486, 16'd27307, 16'd29127, 16'd30948, 16'd32768};
    // Replace the line above with the python generated line when a different frame length or sampling frequency is used
    
    logic[15:0] filt;               // coefficient to be multiplied with current input (times 2^15)
    logic new_window[3];            // indicates the start/end/center of a filter bank
    logic[15:0] bank_shift_reg[40]; // shift register to hold filter bank energies (in dB)
    logic[5:0] d_counter;
    logic[5:0] q_counter;           // counter to keep track and know when to make m_valid
    logic in_ready;                 // internal signal used for s_ready
    logic in_valid[3];              // pipelined s_valid
    logic [31:0] q_in;              // delayed input for pipelined calculations
    logic [31:0] product[2];        // pipelined product
    logic [31:0] inverse[2];        // in - scaled_product
    logic [31:0] q_ascending;
    logic [31:0] d_ascending;
    logic [31:0] q_descending;
    logic [31:0] d_descending;      // ascending and descending side lobes of the filter banks
    logic [31:0] accumulation;      // just used to save one adder
    logic [15:0] dB;                //take dB of spectral energy
    
    assign s_ready = in_ready;
    assign in_valid[0] = s_valid;
    assign filt = filt_shift_reg[0];
    assign new_window[0] = (filt == 16'd32768);
    
//    assign product = in * filt;
    assign inverse[0] = q_in - product[0];
    assign accumulation = q_ascending + product[1];
    
    assign out = bank_shift_reg;
    assign m_valid = (q_counter == 41);
    
    dB_LUT dB_calculator(.in(q_descending), .out(dB), .on(new_window[2]));

    mult_gen_1 mult_im (
      .CLK(clk),  // input wire CLK
      .A(in),      // input wire [31 : 0] A
      .B(filt),      // input wire [15 : 0] B
      .P(product[0])      // output wire [63 : 0] P
    );
    
    always_comb begin        
        if(in_valid[2] && s_ready) begin
            if(new_window[2]) begin
               d_ascending = 0;
                d_descending = accumulation;
                d_counter = q_counter + 1;
            end
            else begin
                d_ascending = accumulation;
                d_descending = q_descending + inverse[1];
                d_counter = q_counter;
            end
        end
        else begin
            d_ascending = q_ascending;
            d_descending = q_descending;
            if(m_valid & m_ready) begin
                d_counter = 0;                
            end
            else begin
                d_counter = q_counter;
            end
        end
    end
    
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            in_ready <= 0;
            q_in <= 0;
            new_window[1:2] <= {0,0};
            in_valid[1:2] <= {0,0};
            product[0:1] <= {0,0};
            inverse[1] <= 0;
            q_counter <= 0;
            q_ascending <= 0;
            q_descending <= 0;
            // uncomment the line below to enable asynchronous reset
//            filt_shift_reg = {16'd32768, 16'd32768, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd16384, 16'd32768, 16'd10922, 16'd21845, 16'd32768, 16'd16384, 16'd32768, 16'd10922, 16'd21845, 16'd32768, 16'd10922, 16'd21845, 16'd32768, 16'd10922, 16'd21845, 16'd32768, 16'd8192,  16'd16384, 16'd24576, 16'd32768, 16'd10922, 16'd21845, 16'd32768, 16'd8192, 16'd16384,  16'd24576, 16'd32768, 16'd8192, 16'd16384, 16'd24576, 16'd32768, 16'd8192, 16'd16384,   16'd24576, 16'd32768, 16'd6553, 16'd13107, 16'd19660, 16'd26214, 16'd32768, 16'd6553, 16'd13107, 16'd19660, 16'd26214, 16'd32768, 16'd6553, 16'd13107, 16'd19660, 16'd26214, 16'd32768, 16'd5461, 16'd10922, 16'd16384, 16'd21845, 16'd27306, 16'd32768, 16'd5461,  16'd10922, 16'd16384, 16'd21845, 16'd27306, 16'd32768, 16'd4681, 16'd9362, 16'd14043,   16'd18724, 16'd23405, 16'd28086, 16'd32768, 16'd4681, 16'd9362, 16'd14043, 16'd18724, 16'd23405, 16'd28086, 16'd32768, 16'd4681, 16'd9362, 16'd14043, 16'd18724, 16'd23405, 16'd28086, 16'd32768, 16'd4096, 16'd8192, 16'd12288, 16'd16384, 16'd20480, 16'd24576, 16'd28672, 16'd32768, 16'd3640, 16'd7281, 16'd10922, 16'd14563, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd3640, 16'd7281, 16'd10922, 16'd14563, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd3640, 16'd7281, 16'd10922, 16'd14563, 16'd18204, 16'd21845, 16'd25486, 16'd29127, 16'd32768, 16'd2978, 16'd5957, 16'd8936, 16'd11915, 16'd14894, 16'd17873, 16'd20852, 16'd23831, 16'd26810, 16'd29789, 16'd32768, 16'd2978, 16'd5957, 16'd8936, 16'd11915, 16'd14894, 16'd17873, 16'd20852, 16'd23831, 16'd26810, 16'd29789, 16'd32768, 16'd2730, 16'd5461, 16'd8192, 16'd10922, 16'd13653, 16'd16384, 16'd19114, 16'd21845, 16'd24576, 16'd27306, 16'd30037, 16'd32768, 16'd2730, 16'd5461, 16'd8192, 16'd10922, 16'd13653, 16'd16384, 16'd19114, 16'd21845, 16'd24576, 16'd27306, 16'd30037, 16'd32768, 16'd2340, 16'd4681, 16'd7021, 16'd9362, 16'd11702, 16'd14043, 16'd16384, 16'd18724, 16'd21065, 16'd23405, 16'd25746, 16'd28086, 16'd30427, 16'd32768, 16'd2340, 16'd4681, 16'd7021, 16'd9362, 16'd11702, 16'd14043, 16'd16384, 16'd18724, 16'd21065, 16'd23405, 16'd25746, 16'd28086, 16'd30427, 16'd32768, 16'd2048, 16'd4096, 16'd6144, 16'd8192, 16'd10240, 16'd12288, 16'd14336, 16'd16384, 16'd18432, 16'd20480, 16'd22528, 16'd24576, 16'd26624, 16'd28672, 16'd30720, 16'd32768, 16'd2048, 16'd4096, 16'd6144, 16'd8192, 16'd10240, 16'd12288, 16'd14336, 16'd16384, 16'd18432, 16'd20480, 16'd22528, 16'd24576, 16'd26624, 16'd28672, 16'd30720, 16'd32768, 16'd1820, 16'd3640, 16'd5461, 16'd7281, 16'd9102, 16'd10922, 16'd12743, 16'd14563, 16'd16384, 16'd18204, 16'd20024, 16'd21845, 16'd23665, 16'd25486, 16'd27306, 16'd29127, 16'd30947, 16'd32768};
                
            
        end
        else begin
            in_ready <= 1'b1;
            q_in <= in;
            new_window[1:2] <= new_window[0:1];
            in_valid[1:2] <= in_valid[0:1];
//            scaled_product[0] <= product[47:15];
            product[1] <= product[0];
            inverse[1] <= inverse[0];
            q_counter <= d_counter;
            q_ascending <= d_ascending;
            q_descending <= d_descending;
        
            if(s_valid & s_ready) begin
                filt_shift_reg[N-1] <= filt_shift_reg[0];
                filt_shift_reg[0:N-2] <= filt_shift_reg[1:N-1];
            end
            
            if(new_window[2] & in_valid[2]) begin
                bank_shift_reg[39] <= dB;
                bank_shift_reg[0:38] <= bank_shift_reg[1:39];
            end
            
        end
    end
endmodule

