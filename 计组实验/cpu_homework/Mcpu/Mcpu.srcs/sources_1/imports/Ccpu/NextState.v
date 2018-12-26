`timescale 1ns / 1ps
`include "head.v"
module NextState(input [2:0] NowStateIn,input [5:0] op,output reg [2:0] NextStateOut);
    always@(NowStateIn or op) begin
        case (NowStateIn)
			`IF: NextStateOut=`ID;
			`ID: begin
				if((op==`J)||(op==`JAL)||(op==`JR)||(op==`HALT)) NextStateOut=`IF;
				else NextStateOut=`EXE; 
			end
			`EXE:begin 
				case(op)
					`ADD,`SUB,`ADDIU,`AND,`ANDI,`ORI,`XORI,`SLL,`SLT,`SLTI: NextStateOut=`WB;
					`BEQ,`BNE,`BLTZ: NextStateOut=`IF;
					`SW,`LW:NextStateOut=`MEM;
					default:NextStateOut=`WB;
				endcase
			end
			`MEM:begin
				case(op)
				`LW:NextStateOut=`WB;
				`SW:NextStateOut=`IF;
				endcase
			end
			`WB:NextStateOut=`IF;
			default:NextStateOut=000;
        endcase
    end

endmodule