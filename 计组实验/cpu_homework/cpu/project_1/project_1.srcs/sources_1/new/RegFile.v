`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 15:51:19
// Design Name: 
// Module Name: RegFile
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


module RegFile(input clk,input RegWre,input RegDst,input [5:0] opCode,input [4:0] rs,input sign,
	input [4:0] rt,input [4:0] rd,input [15:0] immediate,input DBDataSrc,
	input [31:0] alu_data,input [31:0] dm_data,output [31:0] data1_out,output [31:0] data2_out);

	wire [4:0] WriteReg;
	wire [31:0] WriteData;
	assign WriteReg = RegDst ? rd : rt;
	assign WriteData = DBDataSrc ? dm_data : alu_data;
	reg [31:0] register[0:31];
	assign data1_out = (opCode == 6'b011000) ? immediate[10:6] : register[rs];
	assign data2_out = register[rt];
	assign sign=data1_out[31];
	always @(negedge clk) begin
		if (WriteReg && RegWre==1) register[WriteReg] = WriteData;
	end
	integer i;
	initial begin
		for (i = 0; i < 32; i = i+1) register[i] <= 0; 
	end
endmodule
