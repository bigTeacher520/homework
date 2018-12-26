`timescale 1ns / 1ps
module datamemory(input clk,input mRD,input mWR ,input [31:0] DAddr,input [31:0] DataIn,output reg[31:0] DataOut);
    reg [7:0] dataMemory [0:128];
	integer i;
    initial begin
        for (i = 0; i < 128; i = i+1) dataMemory[i] <= 0;
    end
	always@( mRD or DAddr ) begin 
        if (mRD == 1) begin
            DataOut[7:0] = dataMemory[DAddr + 3];
            DataOut[15:8] = dataMemory[DAddr + 2];
            DataOut[23:16] = dataMemory[DAddr + 1];
            DataOut[31:24] = dataMemory[DAddr];
        end
    end

    always @( negedge clk ) begin 
        if (mWR == 1) begin
            dataMemory[DAddr + 3] = DataIn[7:0];
            dataMemory[DAddr + 2]= DataIn[15:8];
            dataMemory[DAddr + 1] = DataIn[23:16];
            dataMemory[DAddr] = DataIn[31:24];
        end
    end
endmodule