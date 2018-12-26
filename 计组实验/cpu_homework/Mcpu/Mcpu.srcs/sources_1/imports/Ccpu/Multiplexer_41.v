`timescale 1ns / 1ps
module Multiplexer_41(input CLK,input [1:0] PCSrc,input [31:0] S0,
	input [31:0] S1,input [31:0] S2,input [31:0] S3,output reg [31:0] out);
    always@(posedge CLK) begin
        case(PCSrc)
            2'b00: out <= S0;
            2'b01: out <= S1;
            2'b10: out <= S2;
            2'b11: out <= S3;
        endcase
    end
endmodule