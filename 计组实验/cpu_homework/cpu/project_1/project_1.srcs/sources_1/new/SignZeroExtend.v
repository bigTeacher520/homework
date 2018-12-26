`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/04 19:20:46
// Design Name: 
// Module Name: SignZeroExtend
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


module signZeroExtend(input [15:0] immediate,input ExtSel,output [31:0] result);
    assign result[15:0] = immediate;
    assign result[31:16] = ExtSel ? (immediate[15]==1 ? 16'b1111111111111111: 16'b0000000000000000) : 16'b0000000000000000;
endmodule
