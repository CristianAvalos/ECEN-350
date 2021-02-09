// NAME: Cristian Avalos
?? UIN: 627003137
module SignExtender(in, out, ctrl);
   input [25:0] in;
   input [1:0] 	ctrl;
   output [63:0] out;
   reg [63:0] 	 out;

   always @(in, ctrl)
     begin
	case(ctrl)
	  2'b00: out = { {55{in[20]}}, in[20:12]};
	  2'b01: out = { {43{in[23]}}, in[23:5], 2'b0};
	  2'b10: out = { {36{in[25]}}, in[25:0], 2'b0};
	  2'b11: out = { {52{in[21]}}, in[21:10]};      
	endcase // case (ctrl)
     end
endmodule // SignExtender
