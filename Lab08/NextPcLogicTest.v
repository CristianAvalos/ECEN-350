// NAME: Cristian Avalos
`define STRLEN 39
module NextPcLogicTest;
   task passTest; // same as previouse labs
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0] 	  passed;
      if(actualOut == expectedOut) 
	begin 
	   $display("%s passed", testType);
	   passed = passed + 1;
	end
      else $display("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask // passTest
   
   task allPassed; // same as previous labs
      input [7:0] passed;
      input [7:0] numTests;
      if(passed == numTests) $display("All tests passed");
      else $display("Some tests failed");
   endtask // allPassed

   // Inputs
   reg [63:0] 	  CurrentPC, SignExtImm64;
   reg 		  Branch, ALUZero, Uncondbranch;
   reg [7:0] 	  passed;
   reg [7:0] 	  numTests;
   // Outputs
   wire [63:0] 	  NextPC;
   reg [63:0] 	  expectedNextPC;

   initial // dump all wire/reg values to dump file
     begin
	$dumpfile("NextPcLogicTest.vcd");
	$dumpvars(0, NextPcLogicTest);
     end
   
   // Instantiate the Unit Under Test (UUT)
   NextPcLogic uut(
		   .NextPC(NextPC),
		   .CurrentPC(CurrentPC),
		   .SignExtImm64(SignExtImm64),
		   .Branch(Branch),
		   .ALUZero(ALUZero),
		   .Uncondbranch(Uncondbranch)
		   );
   initial 
     begin
	// Initialize Inputs
	CurrentPC = 64'b0;
	SignExtImm64 = 64'b0;
	Branch = 1'b0;
	ALUZero = 1'b0;
	Uncondbranch = 1'b0;
	passed = 7'b0;
	numTests = 7'b0;
	#3;
	CurrentPC = 64'h10;
	SignExtImm64 = 64'b0;
	Branch = 1'b0;
	ALUZero = 1'b0;
	Uncondbranch = 1'b0;
	expectedNextPC = 64'h14;
	#4;
	$display("CurrentPC: %d \n SignExtImm64: %d \n  Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, expectedNextPC);
	passTest(NextPC, expectedNextPC, "PC + 4 Test", passed);
	numTests = numTests + 1;
	CurrentPC = 64'h10;
	SignExtImm64 = 64'h2;
	Branch = 1'b1;
	ALUZero = 1'b1;
	Uncondbranch = 1'b0;
	expectedNextPC = 64'h18;
	#4;
	$display("\n CurrentPC: %d \n SignExtImm64: %d \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, expectedNextPC);
	passTest(NextPC, expectedNextPC, "Conditional - Take Branch. \n Test", passed);
	numTests = numTests + 1;
	CurrentPC = 64'h10;
	SignExtImm64 = 64'h3;
	Branch = 1'b1;
	ALUZero = 1'b0;
	Uncondbranch = 1'b0;
	expectedNextPC = 64'h14;
	#4;
	$display("\n CurrentPC: %d \n SignExtImm64: %d \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, expectedNextPC);	
	passTest(NextPC, expectedNextPC, "Conditional - Don't Take Branch. \n Test", passed);
	numTests = numTests + 1;
	CurrentPC = 64'h10;
	SignExtImm64 = 64'h4;
	Branch = 1'b0;
	ALUZero = 1'b0;
	Uncondbranch = 1'b1;
	expectedNextPC = 64'h20;
	#4;
	$display("\n CurrentPC: %d \n SignExtImm64: %d \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, expectedNextPC);
	passTest(NextPC, expectedNextPC, "Unconditional Branch. \n Test", passed);
	numTests = numTests + 1;
	allPassed(passed, numTests);
	$finish;
     end // initial begin
endmodule // NextPcLogicTest
