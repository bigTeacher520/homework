`timescale 1ns / 1ps
`include "head.v"
module OutputFunc(input [2:0] NowStateIn, input [5:0] op,input zero, input sign,             
    output reg PCWre, output reg ExtSel,output reg InsMemRW,output reg IRWre,       
	output reg WrRegDSrc,output reg [1:0] RegDst,output reg RegWre, output reg ALUSrcA,     
	output reg ALUSrcB,output reg [1:0] PCSrc,output reg [2:0] ALUOp,output reg mRD,output reg mWR,         
	output reg DBDataSrc);
    
    always@(NowStateIn or zero or sign) begin
        PCWre = (NowStateIn == `IF && op != `HALT) ? 1: 0;
        ExtSel = (NowStateIn == `EXE) ? ((op == `ORI || op == `ANDI|| op == `XORI) ? 0 : 1) : 1;
        InsMemRW = (NowStateIn == `IF) ? 1 : 0;
        IRWre = (NowStateIn == `IF) ? 1 : 0;
        WrRegDSrc = (NowStateIn == `ID && op == `JAL) ? 0 : 1;
        RegDst[1] = (NowStateIn == `WB) ? ((op == `ADD || op == `SUB || op == `SLT || op == `AND) ? 1 : 0) : 0;
        RegDst[0] = (NowStateIn == `WB) ? ((op == `ADD || op == `SUB || op == `SLT || op == `AND) ? 0 : 1) : 0;
        RegWre = (NowStateIn == `WB) ? 1 : ((NowStateIn == `ID && op == `JAL) ? 1 : 0);
        ALUSrcA = (NowStateIn == `EXE && op == `SLL) ? 1 : 0;
        ALUSrcB = (NowStateIn == `EXE) ? ((op == `ADDIU || op == `ORI || op == `XORI|| op == `ANDI|| op == `SLTI || op == `SW || op == `LW) ? 1 : 0) : 0;
        ALUOp[2] = (NowStateIn == `EXE) ? ((op == `ORI || op == `AND || op == `ANDI || op == `SLTI||op == `SLT||op == `BLTZ) ? 1 : 0) : 0;
        ALUOp[1] = (NowStateIn == `EXE) ? ((op == `ORI || op == `XORI || op == `SLL ||op == `SLT ||op == `SLTI||op == `BLTZ )?1:0) : 0;
        ALUOp[0] = (NowStateIn == `EXE) ? ((op == `SUB  || op == `ORI || op == `XORI || op == `BEQ || op == `BNE) ? 1 : 0) : 0;
        mRD = (NowStateIn == `MEM && op == `LW) ? 1 : 0;
        mWR = (NowStateIn == `MEM && op == `SW) ? 1 : 0;
        DBDataSrc = (NowStateIn == `MEM && op == `LW) ? 1 : 0;
		PCSrc[1] = (NowStateIn == `ID) ? 1 : 0;
        PCSrc[0] = (NowStateIn == `ID) ? ((op == `J || op == `JAL) ? 1 : 0) : ((NowStateIn == `EXE) ? (((op == `BEQ && zero == 1) || (op == `BNE && zero == 0)||(op == `BLTZ && sign == 1)) ? 1 : 0): 0);
        
	end
    
endmodule