`timescale 1ns / 1ps

module ControlUnit(input CLK,input RST,input [5:0] op,input zero,
	input sign,output PCWre,output ExtSel,output InsMemRW,output IRWre,
	output WrRegDSrc,output [1:0] RegDst,output RegWre,output ALUSrcA,
	output ALUSrcB,output [1:0] PCSrc,output [2:0] ALUOp,output mRD,
	output mWR,output DBDataSrc,output [2:0] StateIn,output [2:0] StateOut);


    DFlipFlop DF(.StateIn(StateIn), .CLK(CLK), .RST(RST), 
        .StateOut(StateOut));
    NextState NS(.NowStateIn(StateOut), .op(op), 
        .NextStateOut(StateIn));
    OutputFunc OUTPUT(.NowStateIn(StateOut), .op(op), .zero(zero), .sign(sign), 
        .PCWre(PCWre), .ExtSel(ExtSel), .InsMemRW(InsMemRW), .IRWre(IRWre), 
        .WrRegDSrc(WrRegDSrc), .RegDst(RegDst), .RegWre(RegWre), .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB), .PCSrc(PCSrc), .ALUOp(ALUOp), .mRD(mRD), .mWR(mWR), 
        .DBDataSrc(DBDataSrc));
endmodule
