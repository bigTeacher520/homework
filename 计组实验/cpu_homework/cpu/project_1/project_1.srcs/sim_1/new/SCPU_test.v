`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 20:54:29
// Design Name: 
// Module Name: SCPU_test
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


module SCPU_test;
     reg clk;
   reg Reset;
   wire sign,zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, nRD, nWR, RegDst, ExtSel;
   wire [1:0] PCSrc;
   wire [2:0] ALUOp;

   wire[5:0] opCode;
   wire[4:0] rs, rt, rd;
   wire[15:0] immediate;
   wire[5:0] sa;
   wire[25:0] addr;
   wire[31:0] Out1;
   wire[31:0] Out2;
   wire[31:0] currentPC;
   wire[31:0] Result;
   
   SCPU uut (
       .sign(sign),
       .clk(clk),
       .Reset(Reset),
       .opCode(opCode),
       .rs(rs),
       .rt(rt),
       .rd(rd),
       .immediate(immediate),
       .sa(sa),
       .addr(addr),
       .zero(zero),
       .PCWre(PCWre),
       .ALUSrcA(ALUSrcA),
       .ALUSrcB(ALUSrcB),
       .DBDataSrc(DBDataSrc),
       .RegWre(RegWre),
       .InsMemRW(InsMemRW),
       .nRD(nRD),
       .nWR(nWR),
       .RegDst(RegDst),
       .ExtSel(ExtSel),
       .PCSrc(PCSrc),
       .ALUOp(ALUOp),
       .Out1(Out1),
       .Out2(Out2),
       .currentPC(currentPC),
       .Result(Result)
   );

   initial begin
       // Initialize Inputs
       clk = 0;
       Reset = 0;
       #10; // 刚开始设置pc为0
           clk = 1;
       #10;
           Reset = 1;
       forever #10 begin // 产生时钟信号
           clk = !clk;
       end
   end

endmodule