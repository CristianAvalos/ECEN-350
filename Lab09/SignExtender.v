// NAME: Cristian Avalos UIN: 627003137
`timescale 1ns / 1ps

module SignExtender(out, in, ctrl);
   input [25:0] in;
   input [1:0] 	ctrl;
   output [63:0] out;
   reg [63:0] 	 out;

   always @(*)
     begin
      case(ctrl)
        2'b00: out <= { {55{in[20]}}, in[20:12]}; // D-Type
        2'b01: out <= { {43{in[23]}}, in[23:5], 2'b0}; // CB
        2'b10: out <= { {36{in[25]}}, in[25:0], 2'b0}; // B
        2'b11: out <= {52'b0, in[21:10]}; // I-Type 52{in[21]}}
      endcase // case (ctrl)
     end
endmodule // SignExtender