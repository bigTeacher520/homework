`timescale 1ns / 1ps
module DFlipFlop(
    input [2:0] StateIn,                // ??????
    input CLK,                          // ??????
    input RST,                          // ???????
    output reg [2:0] StateOut           // ?????
    );
    
    always@(posedge CLK) begin
        if(!RST) StateOut <= 3'b000;
        else StateOut <= StateIn;
    end

endmodule