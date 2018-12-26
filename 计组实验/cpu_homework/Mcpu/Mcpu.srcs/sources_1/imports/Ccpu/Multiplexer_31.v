`timescale 1ns / 1ps
module Multiplexer_31(input [1:0] control,
	input [4:0] S1,input [4:0] S2,output [4:0] out);
    assign out = control[1] ? S2 : (control[0] ? S1 : 5'b11111);
endmodule