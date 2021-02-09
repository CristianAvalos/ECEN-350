// NAME: Cristian Avalos
`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
     
    assign #2 BusA = registers[RA];
    assign #2 BusB = registers[RB];

    initial
      begin
	      registers[31] <= #3 64'b0;
      end
   
    always @(negedge Clk) 
      begin
        registers[31] <= #3 64'b0;
        if(RegWr && RW != 5'b11111)
          registers[RW] <= #3 BusW;
      end
endmodule // RegisterFile
