// Name: Cristian Avalos | UIN: 627003137
module HalfAdd(sum, carry, a, b);
   input wire a, b;        // input wires
   output wire sum, carry; // outputs
   wire w1, w2, w3;        // internal wires
   // four nand gates equal one xor gate
   nand nand1(w1, a, b);   // first nand gate
   nand nand2(w2, a, w1);  // second nand gate
   nand nand3(w3, b, w1);  // this nand gate
   nand nandSum(sum, w2,w3); // last nand gate, sum output
   nand nandCarry(carry, w1, w1); // carry output
endmodule 
