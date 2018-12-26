`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/04 19:03:06
// Design Name: 
// Module Name: ALU
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



module ALU(input [31:0] data1,input [31:0] data2,input [31:0] immediate,input [5:0] sa,
    input [2:0] ALUOp,input ALUSrcA,input ALUSrcB,output reg [31:0] result,output zero);
	wire [31:0] getdata1;
	wire [31:0] getdata2;
	assign getdata1=ALUSrcA?sa:data1;
	assign getdata2=ALUSrcB?immediate:data2;
	assign zero=(result==0)?1:0;
	always @(data1 or data2 or immediate  or ALUOp or ALUSrcA or ALUSrcB or getdata1 or getdata2) begin
		case(ALUOp)
			3'b000:result=getdata1 + getdata2;
			3'b001:result=getdata1 - getdata2;
			3'b010:result=getdata2 << getdata1;
			3'b011:result=getdata1 | getdata2;
			3'b100:result=getdata1 & getdata2;
			3'b101:result=(getdata1<getdata2)?1:0;
			3'b110:result=(((getdata1<getdata2)&&(getdata1[31] == getdata2[31])) ||((getdata1[31]==1&& getdata2[31] == 0))) ? 1:0;
			3'b111:result=getdata1 ^~ getdata2;
		endcase
	end
	
endmodule