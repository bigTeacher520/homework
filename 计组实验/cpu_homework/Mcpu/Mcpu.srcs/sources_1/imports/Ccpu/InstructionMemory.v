`timescale 1ns / 1ps
module InstructionMemory(input InsMemRW,input [31:0]pc,output reg[31:0] out);
	reg [7:0] memory[0:127];
	initial begin
		$readmemb("instruction.mem",memory);
	end
	always@(InsMemRW or pc) begin
		if(InsMemRW) begin
			out ={memory[pc],memory[pc+1],memory[pc+2],memory[pc+3]};
		end
	end
endmodule