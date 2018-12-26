`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 19:55:14
// Design Name: 
// Module Name: datamemory_sim
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
module dataMemory_sim;
// input
reg clk;
reg [31:0] address;
reg [31:0] DataIn;reg mRD;
reg mWR;
// output
wire [31:0] DataOut;
dataMemory uut(
.clk(clk),
.address(address),
.DataIn(DataIn),
.mRD(mRD),
.mWR(mWR),
.DataOut(DataOut)
);
always #15 clk = !clk;
initial begin
clk = 0;
address = 0;
DataIn = 0;
mRD = 1; // Ϊ 0�� �������� Ϊ 1,�������̬
mWR = 1; // Ϊ 0�� д�� Ϊ 1�� �޲���
#30; // 30 ����� clk �½���д
address = 8;
DataIn = 8;
mRD = 1; // Ϊ 0�� �������� Ϊ 1,�������̬
mWR = 0; // Ϊ 0�� д�� Ϊ 1�� �޲���
#30; // 60 ����� clk �½���д
address = 12;
DataIn = 12;
mRD = 1; // Ϊ 0�� �������� Ϊ 1,�������̬
mWR = 0; // Ϊ 0�� д�� Ϊ 1�� �޲���
#30; // 90 ���뿪ʼ��
address = 8;
mRD = 0; // Ϊ 0�� �������� Ϊ 1,�������̬
mWR = 1; // Ϊ 0�� д�� Ϊ 1�� �޲���
#30; // 120 ���뿪ʼ��
address = 12;
mRD = 0; // Ϊ 0�� �������� Ϊ 1,�������̬
mWR = 1; // Ϊ 0�� д�� Ϊ 1�� �޲���#30 $stop; // 150 ���� ͣ
end
endmodule