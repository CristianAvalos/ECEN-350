// Name: Cristian Avalos
module Decode24 (out , in);
   input [1:0] in;
   output [3:0] out;
   reg [3:0] 	out;
   
   always @(in)
     begin
	case(in)
	  2'b00: out = 4'b0001;
	  2'b01: out = 4'b0010;
	  2'b10: out = 4'b0100;
	  2'b11: out = 4'b1000;
	endcase // case (in)
     end
   
endmodule // Decode24

   
   
