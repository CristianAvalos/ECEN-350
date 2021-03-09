.section .text
.globl lab03b

lab03b:
	LDR X0, UIN // loads the value of the address found in UIN to X0
	ADD X9, XZR, XZR // initialize X9 with 0, i = 0
loop:	SUBS XZR, X9, #10
	B.GE End_Loop // if X9 is GE to 10, exit loop
	SUB X0,X0, #1 // else, subtract one from the X0
	ADD X9, X9, #1 // increment i
	B loop // loop back
	
End_Loop:  // outside of loop
	BR X30

.section .data
UIN:	.word 0x1D // My UIN is 627003137, total of 29
