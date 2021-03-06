`timescale 1ns / 1ps
module Mcpu(input clk,input RST,output [31:0]curPC,output [31:0]nextPC,output [2:0]curState,
	output [2:0]nextState,output [31:0]ADR,output [31:0]BDR,output [5:0] opCode,output [4:0]rd,
	output [4:0]rs,output [4:0]rt,output [15:0]immediate,output [31:0] sa,
	output [25:0] address,output sign,output mRD, output mWR,output [2:0] ALUOp,output [31:0] alu_out);
	wire [1:0] RegDst;
	wire [1:0] PCSrc;
	wire PCWre,ExtSel,InsMemRW,  IRWre,WrRegDSrc, RegWre, ALUSrcA,ALUSrcB,DBDataSrc;  
	wire [31:0] instruction,getData;
	wire [31:0] WriteData,data1_out,data2_out,DBDR,Aout,Bout,extend_immediate,Daddr,dm_out;
	wire zero;
	wire [4:0] WriteReg;
	PC 	pc(.CLK(clk),.RST(RST),.PCWre(PCWre),.address(nextPC),.curAddress(curPC));
	InstructionMemory  IM(.InsMemRW(InsMemRW),.pc(curPC),.out(instruction));
	InstructionRegister	 IR(.instruction(instruction),.IRWre(IRWre),.CLK(clk),
		.opCode(opCode),.rs(rs),.rt(rt),.rd(rd),
		.immediate(immediate),.sa(sa),.address(address));
	ControlUnit	CU(.CLK(clk), .RST(RST),.op(opCode),.zero(zero),.sign(sign),             
		.PCWre(PCWre),.ExtSel(ExtSel),.InsMemRW(InsMemRW),.IRWre(IRWre),           
		.WrRegDSrc(WrRegDSrc),.RegDst(RegDst),.RegWre(RegWre),          
		.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.PCSrc(PCSrc),     
		.ALUOp(ALUOp),.mRD(mRD),.mWR(mWR),.DBDataSrc(DBDataSrc),
		.StateIn(curState),.StateOut(nextState));
	Multiplexer_31 WriteChoose(.control(RegDst),.S1(rt),.S2(rd),.out(WriteReg));
	Multiplexer_21 DataChoose(.control(WrRegDSrc),.S0(curPC),.S1(DBDR),.out(WriteReg));
	RegFile Reg(.clk(clk),.RegWre(RegWre),.RST(RST),.rs(rs), 
		.rt(rt),.WriteReg(WriteReg),.WriteData(WriteData),
		.data1_out(data1_out),.data2_out(data2_out));
	DR AStor(.CLK(clk),.DRIn(data1_out),.DROut(ADR));
	DR BStor(.CLK(clk),.DRIn(data2_out),.DROut(BDR));
	Multiplexer_21 Adata(.control(ALUSrcA),.S0(ADR),.S1(sa),.out(Aout));
	signZeroExtend imExtend(.immediate(immediate),.ExtSel(ExtSel),.result(extend_immediate)); 
	Multiplexer_21 Bdata(.control(ALUSrcB),.S0(BDR),.S1(extend_immediate),.out(Bout));
	ALU alu(.ALUOp(ALUOp),.A(Aout), .B(Bout),.zero(zero),.sign(sign),.result(alu_out));
	PCGenerator pg(.clk(clk),.PCSrc(PCSrc),.curPC(curPC),.immediate(extend_immediate),
            .addr(address), .nextPC(nextPC));
	datamemory  dm(.clk(clk),.mRD(mRD),.mWR(mWR),.DAddr(alu_out),.DataIn(BDR),.DataOut(dm_out));
	Multiplexer_21 aluChoose(.control(alu_out),.S0(DBDataSrc),.S1(dm_out),.out(getData));
	DR dr(.CLK(clk),.DRIn(getData),.DROut(DBDR));
	
endmodule