`timescale 1ns / 1ps
module PCGenerator(input clk,input [1:0]PCSrc,input [31:0] curPC,input [31:0]immediate,
		input[25:0] addr,input[31:0]data, output reg[31:0] nextPC);
	reg [31:0] arg;
	always @(posedge clk ) begin
		case(PCSrc)
			2'b00:nextPC=curPC+4;
			2'b01:nextPC=curPC+4+immediate*4;
			2'b10:nextPC=data+4;
			2'b11:begin
			   arg=curPC+4;
			   nextPC={ arg[31:28],addr[25:0],2'b00};
			end
			default: begin
                nextPC = curPC + 4;                    
            end
		endcase
	end
endmodule