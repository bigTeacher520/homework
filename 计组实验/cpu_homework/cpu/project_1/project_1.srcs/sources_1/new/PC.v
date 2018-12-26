`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/04 16:58:12
// Design Name: 
// Module Name: PC
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


module PC(input clk,input Reset,input PCWre,input [1:0]PCSrc,
		input [31:0]immediate,input [25:0] addr,output reg[31:0] address);
	reg [31:0] arg;
	always @(posedge clk or negedge Reset)
		begin
			if(Reset==0) begin
				address=0;
			end
			else if(PCWre==1) begin
				case(PCSrc)
					2'b00:address=address+4;
					2'b01:address=address+4+immediate*4;
					2'b10:begin
					   arg=address+4;
					   address={ arg[31:28],addr[27:2],2'b00};
					end
					default: begin
                        address = address + 4;                    
                    end
				endcase
			end
		end
endmodule