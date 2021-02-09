`define STRLEN 15
module SignExtenderTest;
   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0] 	  passed;
      if (actualOut == expectedOut)
	begin
	   $display("%s passed", testType);
	   passed = passed + 1;
	end
      else
	$display("%s failed: %d should be %d", testType,actualOut, expectedOut);
   endtask // passTest

   task allPassed;
      input [7:0] passed;
      input [7:0] numTests;
      if (passed == numTests) $display("All tests passed");
      else $display("Some tests failed");
   endtask // allPassed

   // inptus
   reg [25:0] 	  in;
   reg [1:0] 	  ctrl;
   reg [7:0] 	  passed;
   // outputs
   wire [63:0] 	  out;

   initial // dump all wire/reg values to dump file
     begin
	$dumpfile("SignExtenderTest.vcd");
	$dumpvars(0, SignExtenderTest);
     end

   // instantiate the Unit Under Test
   SignExtender uut (
		     .in(in),
		     .ctrl(ctrl),
		     .out(out)
   );
   initial
     begin
	// initialize inputs
	in = 26'b0;
	ctrl = 0;
	passed = 0;
	// stimulus
	#90; in = 26'b00_0000_0011_1111_0000_0000_0000;
	ctrl = 2'b00; #10; passTest(out,64'b11_1111, "(+)D-Type", passed);
	#90; in = -26'b00_0000_0011_1111_0000_0000_0000;
	ctrl = 2'b00; #10; passTest(out, -64'b11_1111, "(-)D-Type", passed);
	
	#90; in = 26'b00_0000_0000_0000_0111_1110_0000;
	ctrl = 2'b01; #10; passTest(out, 64'b11_111100, "(+)CB-Type", passed);
	#90; in = -26'b00_0000_0000_0000_0111_1110_0000;
	ctrl = 2'b01; #10; passTest(out, -64'b11_111100, "(-)CB-Type", passed);
	
	
	#90; in = 26'b00_0000_0000_0000_0000_0011_1111;
	ctrl = 2'b10; #10; passTest(out, 64'b11_111100, "(+)B-Type", passed);
	#90; in = -26'b00_0000_0000_0000_0000_0011_1111;
	ctrl = 2'b10; #10; passTest(out, -64'b11_111100, "(-)B-Type", passed);
	
	#90; in = 26'b00_0000_0000_1111_1100_0000_0000;
	ctrl = 2'b11; #10; passTest(out, 64'b11_1111, "(+)I-type", passed);
	#90; in = -26'b00_0000_0000_1111_1100_0000_0000;
	ctrl = 2'b11; #10; passTest(out, -64'b11_1111, "(-)I-type", passed);
	#90;
	allPassed(passed, 8);
     end // initial begin
endmodule // SignExtenderTest

   
	
