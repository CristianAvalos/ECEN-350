`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

   initial // dump all wire/reg values to dump file
     begin
	$dumpfile("ALUTest.vcd");

	$dumpvars(0, ALUTest);

     end
   
	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 64'hABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
	   // add
	   {BusA, BusB, ALUCtrl} = {64'h86235, 64'hFEFA, 4'h2}; #40; passTest({Zero, BusW}, 64'h9612F, "ADD 0x86235,0xFEFA", passed);
	   {BusA, BusB, ALUCtrl} = {64'hFFFF, 64'hBEEF, 4'h2}; #40; passTest({Zero, BusW}, 64'h1BEEE, "ADD 0xFFFF,0xBEEF", passed);
	   {BusA, BusB, ALUCtrl} = {64'h54321, 64'h12345, 4'h2}; #40; passTest({Zero, BusW}, 64'h66666, "ADD 0x54321,0x12345", passed);
	   
	   // sub
	   {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h6}; #40; passTest({Zero, BusW}, 64'hFFFFFFFF54331234, "SUB 0x1234,0xABCD0000", passed);
	   {BusA, BusB, ALUCtrl} = {64'hDADA, 64'h246813579, 4'h6}; #40; passTest({Zero, BusW}, 64'hFFFFFFFDB97FA561, "SUB 0xDADA,0x246813579", passed);
	   {BusA, BusB, ALUCtrl} = {64'h98760123, 64'h7528020, 4'h6}; #40; passTest({Zero, BusW}, 64'h91238103, "SUB 0x98760123,0x7528020", passed);
	   {BusA, BusB, ALUCtrl} = {64'hFEED0000, 64'hACDC, 4'h6}; #40; passTest({Zero, BusW}, 64'hFEEC5324, "SUB 0xFEED0000,0xACDC", passed);
	   
	   // and
	   {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h0}; #40; passTest({Zero, BusW}, 64'h0, "AND 0x1234,0xABCD0000", passed);
	   {BusA, BusB, ALUCtrl} = {64'hFFFFFFFFFFFFFFFF, 64'hDEADBEEFDEADFEED, 4'h0}; #40; passTest({Zero, BusW}, 64'hDEADBEEFDEADFEED, "AND 0xFFFFFFFFFFFFFFFF, 0xDEADBEEFDEADFEED", passed);
	   {BusA, BusB, ALUCtrl} = {64'hCAFEFFFFBEEFFFFF, 64'hBABACAFEDEADBEEF, 4'h0}; #40; passTest({Zero, BusW}, 64'h8ABACAFE9EADBEEF, "AND 0xCAFEFFFFBEEFFFFF, 0xBABACAFEDEADBEEF", passed);
	   {BusA, BusB, ALUCtrl} = {64'h13579, 64'h2468, 4'h0}; #40; passTest({Zero, BusW}, 64'h2468, "AND 0x13579, 0x2468", passed);
	   
	   // or
	   {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h1}; #40; passTest({Zero, BusW}, 64'hABCD1234, "OR 0x1234, 0xABCD0000", passed);
	   {BusA, BusB, ALUCtrl} = {64'h98760000, 64'hFEFEFAFA, 4'h1}; #40; passTest({Zero, BusW}, 64'hFEFEFAFA,"OR 0x98760000, 0xFEFEFAFA", passed);
	   {BusA, BusB, ALUCtrl} = {64'h46785, 64'h58740101, 4'h1}; #40; passTest({Zero, BusW}, 64'h58746785,"OR 0x46785, 0x58740101", passed);
	   {BusA, BusB, ALUCtrl} = {64'h1020304050, 64'hABACADAE, 4'h1}; #40; passTest({Zero, BusW}, 64'h10ABBCEDFE,"OR 0x1020304050, 0xABACADAE", passed);
	   
	   // passb
	   {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h7}; #40; passTest({Zero, BusW}, 64'hABCD0000, "PassB 0x1234, 0xABCD0000", passed);
	   {BusA, BusB, ALUCtrl} = {64'h1, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, 64'h0, "PassB 0x1, 0x0", passed);
	   {BusA, BusB, ALUCtrl} = {64'h0, 64'h1, 4'h7}; #40; passTest({Zero, BusW}, 64'h1, "PassB 0x0, 0x1", passed);
	   {BusA, BusB, ALUCtrl} = {64'hDEAD, 64'hBEEF0000, 4'h7}; #40; passTest({Zero, BusW}, 64'hBEEF0000, "PassB 0xDEAD, 0xBEEF0000", passed);
	   
	   allPassed(passed, 20);
	end
      
endmodule

