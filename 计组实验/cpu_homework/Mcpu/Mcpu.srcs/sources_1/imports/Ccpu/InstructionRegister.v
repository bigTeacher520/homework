`timescale 1ns / 1ps
module InstructionRegister(input [31:0]instruction,input IRWre,input CLK,
	output reg[5:0] opCode,output reg[4:0] rs,output reg[4:0] rt,output reg[4:0] rd,
	output reg[15:0] immediate,output reg[31:0] sa,output reg[25:0] address);
	always@(negedge CLK) begin
		if(IRWre) begin
			opCode = instruction[31:26];
			rs = instruction[25:21];
			rt = instruction[20:16];
			rd = instruction[15:11];
			immediate = instruction[15:0];
			sa = {27'b000000000000000000000000000,instruction[10:6]};
			address = instruction[25:0];
		end
	end
endmodule