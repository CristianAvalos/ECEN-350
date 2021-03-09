.section .text
.globl lab04b

lab04b:
fact:
	SUB SP, SP, 0x10	// allocate space on the stack for X0 and X30
	STUR LR, [SP, 0x8]	// save return address
	STUR X0, [SP, 0x0]	// save variables 1 through n
	CBNZ X0, R1		// if n != 0, go to R1
	ADD X0, XZR, XZR	// else
	ADD X0, X0, 0x1
	ADD SP, SP, 0x20	// pop stack
	BR LR			// return 1
R1:
	SUB X0, X0, 0x1		// n - 1
	BL fact
back:
	LDUR X1, [SP, 0x0]	// pop the variables 1 through n
	BL my_mul		// call the function and pass in X0 and X1
	LDUR LR, [SP, 0x8]	// Load X30 back
	ADD SP, SP, 0x10	// return stack pointer 
	BR LR			// return
