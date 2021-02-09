// NAME: Cristian Avalos UIN: 627003137
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0]; // 32 64-bit registers
     
    assign #2 BusA = registers[RA]; // data from RA send to BusA
    assign #2 BusB = registers[RB]; // data from RB sent to BusB

   initial
     begin
	registers[31] <= #3 64'b0; // always read 0
     end
   
   always @(negedge Clk) // negative clock edge
      begin
	 if(RegWr && RW != 5'b11111) // if RegWr == 1 and  not register 31
	   registers[RW] <= #3 BusW; // data from BusW send to register RW
      end
endmodule // RegisterFile
