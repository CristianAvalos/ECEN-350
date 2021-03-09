.section .text
.globl test2

//test2:
//	sub     X0, X0, X1
//	br      X30
test2:
	sub X1, X0, X1		// X1 = X0 - X1
	adr X0, msg		// X0 gets the address of the output message
	sub SP, SP, 0x10	// allocates space in stack for X30
	stur X30, [SP, 0x0]	// stores X30
	bl printf 		// branch link the printf function
	ldur X30, [SP, 0x0]	// pops X30
	add SP, SP, 0x10	// returns stack pointer
	br X30			// return to main
.section .data
msg: .asciz "Printing from test2() file. Result of test2(6, 5) = %d\n"
