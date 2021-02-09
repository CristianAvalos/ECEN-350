// NAME: Cristian Avalos UIN: 627003137
`timescale 1ns / 1ps
`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
   parameter n = 64;
   output  [n-1:0] BusW;
   input   [n-1:0] BusA, BusB;
   input   [3:0] ALUCtrl;
   output Zero;
   reg [n-1:0] BusW;

   always @(ALUCtrl or BusA or BusB) begin
      case(ALUCtrl)
         `AND: begin
            BusW <= #20 (BusA & BusB);           
         end
         `OR: begin
            BusW <= #20 (BusA | BusB);
         end
         `ADD: begin
            BusW <= #20 (BusA + BusB);
         end
         `SUB: begin
            BusW <= #20 (BusA - BusB);
         end
         `PassB:  begin
            BusW <= #20 BusB;
         end
         default: begin
            BusW <= #20 0;
         end       
      endcase
   end
   assign #1 Zero = BusW ? 1'b0 : 1'b1;
endmodule