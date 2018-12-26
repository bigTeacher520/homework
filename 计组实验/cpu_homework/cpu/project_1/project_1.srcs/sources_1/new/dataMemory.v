`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 15:45:56
// Design Name: 
// Module Name: dataMemory
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




module dataMemory(input clk,input mRD,input mWR ,input [31:0] DAddr,input [31:0] DataIn,output reg[31:0] DataOut);
    reg [7:0] dataMemory [0:128];
	integer i;
    initial begin
        for (i = 0; i < 128; i = i+1) dataMemory[i] <= 0;
    end
	always@( mRD or DAddr ) begin 
        if (mRD == 0) begin
            DataOut[7:0] = dataMemory[DAddr + 3];
            DataOut[15:8] = dataMemory[DAddr + 2];
            DataOut[23:16] = dataMemory[DAddr + 1];
            DataOut[31:24] = dataMemory[DAddr];
        end
    end

    always @( negedge clk ) begin 
        if (mWR == 0) begin
            dataMemory[DAddr + 3] = DataIn[7:0];
            dataMemory[DAddr + 2]= DataIn[15:8];
            dataMemory[DAddr + 1] = DataIn[23:16];
            dataMemory[DAddr] = DataIn[31:24];
        end
    end
endmodule