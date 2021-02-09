// NAME: Cristian Avalos
module NextPcLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
   input [63:0] CurrentPC, SignExtImm64;
   input Branch, ALUZero, Uncondbranch;
   output [63:0] NextPC;
   reg [63:0] 	 NextPC;

   always @(CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch)
     begin
	#1; // delay of 1 for using mux
	if (Uncondbranch) // automatically 1 for mux, so add immediate
	  NextPC <= #2 CurrentPC + (SignExtImm64<<2); // delay of 2 for gen. addition
	else if (Branch)
	  begin
	     if (ALUZero) // 1 for mux, add immediate
	       NextPC <= #2 CurrentPC + (SignExtImm64<<2);
	     else // 0 for mux, so add normal
	       NextPC <= #1 CurrentPC + 4; // delay of 1 for const. addition
	  end
	else NextPC <= #1 CurrentPC + 4; // add normal
     end // always @ (CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch)   
endmodule
