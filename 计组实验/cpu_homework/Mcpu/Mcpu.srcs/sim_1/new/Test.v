`timescale 1ns / 1ps
module TestCPU();
    reg CLK;
    reg RST;
    wire [5:0] opCode;
	wire [2:0] ALUOp;
    wire [2:0] curState;
    wire [2:0] nextState;
    wire [31:0] curPC;
    wire [31:0] nextPC;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [31:0] alu_out;
    wire [31:0] ADR;
    wire [31:0] BDR,WriteData;
    wire [15:0] immediate;
    wire [4:0] rd,WriteReg;
    wire [31:0] sa;
	wire [31:0] Aout;
	wire [31:0] Bout,data1_out,data2_out,DBDR,alu_dr;
	wire RegWre,WrRegDSrc;
	wire [1:0] RegDst,PCSrc;
    wire [25:0] address;
	wire sign,mRD,mWR;
    Mcpu mcpu(.clk(CLK),.RST(RST),.curPC(curPC), .nextPC(nextPC), .curState(curState),
	  .nextState(nextState), .ADR(ADR),.BDR(BDR),.opCode(opCode), .rd(rd),
	  .rs(rs), .rt(rt), .immediate(immediate),.sa(sa),
	  .address(address),.sign(sign), .mRD(mRD),.mWR(mWR),.ALUOp(ALUOp),.alu_out(alu_out),
	  .Aout(Aout),.Bout(Bout),.data1_out(data1_out),.data2_out(data2_out),.DBDR(DBDR),.RegWre(RegWre),
	  .WrRegDSrc(WrRegDSrc),.alu_dr(alu_dr),.RegDst(RegDst),.WriteReg(WriteReg),.WriteData(WriteData),
	  .PCSrc(PCSrc));
	 
    initial begin
        CLK = 0;
        RST = 0;
        #5;
            CLK = 1;
        #5;
            RST = 1;
        forever #5 begin
          CLK = ~CLK;
        end  
    end
 
endmodule