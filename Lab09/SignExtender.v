// NAME: Cristian Avalos UIN: 627003137
`timescale 1ns / 1ps

module SignExtender(out, in, ctrl);
   input [25:0] in;
   input [2:0] 	ctrl;
   output [63:0] out;
   reg [63:0] 	 out;

   always @(*)
     begin
      case(ctrl)
        3'b000: out <= { {55{in[20]}}, in[20:12]}; // D-Type
        3'b001: out <= { {43{in[23]}}, in[23:5], 2'b0}; // CBZ
        3'b010: out <= { {36{in[25]}}, in[25:0], 2'b0}; // B-Type
        3'b011: out <= {52'b0, in[21:10]}; // I-Type
        3'b100:
        begin
          case(in[22:21]) // IW-Type
            2'b00: out <= {48'b0, in[20:5]}; // LSL 0
            2'b01: out <= {32'b0, in[20:5], 16'b0}; // LSL 16
            2'b10: out <= {16'b0, in[20:5], 32'b0}; // LSL 32
            2'b11: out <= {in[20:5], 48'b0}; // LSL 48
			    endcase
        end
        default: out <= 64'bx;
      endcase // case (ctrl)
     end
endmodule // SignExtender