`timescale 1ns / 1ps
`define ADD    6'b000000
`define SUB    6'b000001
`define ADDIU  6'b000010
`define AND    6'b010000
`define ANDI   6'b010001
`define ORI    6'b010010
`define XORI   6'b010011
`define SLL    6'b011000
`define SLTI   6'b100110
`define SLT    6'b100111
`define SW     6'b110000
`define LW     6'b110001
`define BEQ    6'b110100
`define BNE    6'b110101
`define BLTZ   6'b110110
`define J      6'b111000
`define JR     6'b111001
`define JAL    6'b111010
`define HALT   6'b111111
               
`define IF     6'b000
`define ID     6'b001
`define EXE   6'b010
`define MEM    6'b011
`define WB    6'b100