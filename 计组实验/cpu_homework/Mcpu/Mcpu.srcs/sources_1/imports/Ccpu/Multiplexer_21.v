`timescale 1ns / 1ps
module Multiplexer_21(input control,input [31:0] S0,
	input [31:0] S1,output [31:0] out);
    assign out = control ? S1 : S0;
endmodule