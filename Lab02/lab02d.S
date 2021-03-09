.section .text
.globl lab02d

lab02d:
	ADD X1, X0, #1000
	ADR X0, myvalue
	STUR X1,[X0, #0]
	BR X30
	
.section .data
myvalue:	.byte 16
