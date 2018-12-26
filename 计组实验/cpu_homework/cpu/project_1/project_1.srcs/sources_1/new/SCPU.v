`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 20:48:15
// Design Name: 
// Module Name: SCPU
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



module SCPU(
       input clk,
        input Reset,
        input CLR,
        output wire[5:0] opCode,
        output wire[4:0] rs, rt, rd,
        output wire[15:0] immediate, 
        output wire[5:0] sa,
        output wire[25:0] addr,
        output wire sign,zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, nRD, nWR, RegDst, ExtSel,
        output wire[1:0] PCSrc,
        output wire[2:0] ALUOp,
        output wire[31:0] Out1,
        output wire[31:0] Out2,
        output wire[31:0] currentPC,
        output wire[31:0] Result
    );
    
    //wire[2:0] ALUOp;
    wire[31:0] extend, DMOut;
    //wire[15:0] immediate;
    //wire[4:0] rs, rt, rd;
    //wire[5:0] sa;
    //wire[25:0] addr;
    //wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, nRD, nWR, RegDst, ExtSel;
    //wire[1:0] PCSrc;
    
    ALU alu(Out1, Out2, extend, sa, ALUOp, ALUSrcA, ALUSrcB, Result, zero);
    PC pc(clk, Reset, PCWre, PCSrc, extend, addr, currentPC);
    ControlUnit CU(opCode, zero,sign, Reset, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, nRD, nWR, RegDst, ExtSel, PCSrc, ALUOp);
    dataMemory DM(clk, nRD, nWR, Result, Out2, DMOut);
    InstructionMemory IM(currentPC, opCode, rs, rt, rd, immediate, sa, addr);
    RegFile registerFile(clk, RegWre, RegDst, opCode, rs,sign, rt, rd, immediate, DBDataSrc, Result, DMOut, Out1, Out2);
    signZeroExtend SZE(immediate, ExtSel, extend);
    
endmodule

