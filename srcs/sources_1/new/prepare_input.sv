`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 12:40:45 AM
// Design Name: 
// Module Name: prepare_input
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


module prepare_input #(parameter N=512, parameter STRIDE=64)(
    input clk,
    input reset,
    input [15:0] in,
    output [15:0] out,
    
    input s_valid,
    output s_ready,
    output m_valid,
    input m_ready
    );
    localparam STRIDE_CNT_SIZE = $clog2(STRIDE)-1;
    localparam OUT_CNT_SIZE = $clog2(N);
    
    // Replplace the value below with the desired pre_amphisis filter a0 multiplied by 2**15
    logic [15:0] filt = 16'd31785;
    
    logic [OUT_CNT_SIZE:0] q_out_counter;             // counts clock cycles to know when to halt output
    logic [OUT_CNT_SIZE:0] d_out_counter;
    logic [STRIDE_CNT_SIZE:0] q_stride_counter;       // counts input samples to know when to output frame
    logic [STRIDE_CNT_SIZE:0] d_stride_counter;
    
    logic [31:0] product;
    logic [15:0] d_pre_emph;                                // pre emphasis coefficient applied to previous input
    logic [15:0] q_pre_emph;
    
    logic [15:0] frame[N+1];                                // shift register to store frame elements
    logic [15:0] frame_in;                                // input to shift register
    logic frame_en;                                       // enable shift register
    logic frame_en_in;
    logic frame_en_out;
    
    logic q_valid;
    logic d_valid;
    logic started;                                        // high if the system has started receiving valid input, low after valid frame has been output
    
    assign frame_en = frame_en_in | frame_en_out;
    assign m_valid = q_valid & frame_en;
    assign out = m_valid ? frame[N-1] : 0;
    assign d_valid = (q_stride_counter==0 && m_ready && started);
    assign started = q_out_counter < N;
    assign s_ready= !q_valid;
    
    assign product = $signed(filt)*$signed(in);
    assign d_pre_emph = product >> 15;
    
    always_comb begin
        frame_in = (q_valid) ? frame[N-1] : in - q_pre_emph;
        //  INPUT
        if(s_valid & s_ready) begin
            d_stride_counter = q_stride_counter + 1'd1;
            frame_en_in = 1'b1;
        end
        else begin
            d_stride_counter = q_stride_counter;
            frame_en_in = 1'b0;
        end
        
        // OUTPUT        
        if(q_stride_counter == 0) begin
            if(q_valid) begin
                d_out_counter = q_out_counter + started;
                frame_en_out = started;
            end
            else begin 
                d_out_counter = q_out_counter;
                frame_en_out = 0;
            end        
        end
        else begin
            d_out_counter = 0;
            frame_en_out = 0;
        end
                
        
    end
    
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            q_out_counter <= N;
            q_stride_counter <= STRIDE;
            q_valid <= 0;
            q_pre_emph <= 0;
            for(int i=0; i<N+1; i++) begin
                frame[i] <= 0;
            end
        end
        else begin
            q_out_counter <= d_out_counter;
            q_stride_counter <= d_stride_counter;
            q_valid <= d_valid;
            
            if(s_valid) q_pre_emph <= d_pre_emph;
            
            if(frame_en) begin
                frame[0] <= frame_in;
                frame[1:N] <= frame[0:N-1];
            end
        end
    end
    
endmodule