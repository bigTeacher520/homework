`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 15:53:28
// Design Name: 
// Module Name: InstructionMemory
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

module InstructionMemory(input [31:0]pc,  
	output [5:0] opCode,output [4:0] rs,output [4:0] rt,output[4:0] rd,
	output [15:0] immediate,output [5:0] sa,output [25:0] address);
	reg [7:0] memory[127:0];
	reg [31:0] instruction;
	initial begin
		$readmemb("instructions.mem",memory);
	end
	always @(pc) begin
		instruction={memory[pc],memory[pc+1],memory[pc+2],memory[pc+3]};
	end
	assign opCode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign immediate = instruction[15:0];
    assign sa = instruction[10:6];
    assign address = instruction[25:0];
endmodule