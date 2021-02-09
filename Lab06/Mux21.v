// Name: Cristian Avalos | UIN: 627003137
`timescale 1ns / 1ps
`default_nettype none

module Mux21(sel, in, out);
   input wire [0:1] in;       // inputs I0, I1
   input wire sel;            // input sel
   output wire out;           // output
   wire notS, and1, and2;     // internal wires
   not not1(notS, sel);       // not sel
   and and1(and1, sel, in[0]);// first and gate with sel and I0
   and and2(and2, notS, in[1]);// second and with not sel and I1
   or or1(out, and1, and2);   // output with or gate
endmodule
