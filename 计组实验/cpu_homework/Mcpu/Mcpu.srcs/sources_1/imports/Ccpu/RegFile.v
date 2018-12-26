`timescale 1ns / 1ps
module RegFile(input clk,input RegWre,input RST,input [4:0] rs, 
	input [4:0] rt,input [4:0] WriteReg,input [31:0]WriteData,
	output [31:0] data1_out,output [31:0] data2_out);
	reg [31:0] register[0:31];
	integer i;
        initial begin
            for (i = 0; i < 32; i = i+1) register[i] <= 0; 
        end
	assign data1_out = register[rs];
	assign data2_out = register[rt];
	always@(negedge clk ) begin
        if(!RST) begin
            for(i = 1; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end
        else if(RegWre && WriteReg != 0) begin
            register[WriteReg] <= WriteData;
        end
    end
	
endmodule