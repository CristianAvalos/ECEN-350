.section .text
.globl lab03c

lab03c:
	ADRP X0, my_array
        ADD X0, X0, :lo12:my_array // loads the address of my_array to X0
	ADD X9, XZR, XZR // Initialize and add my first digit of UIN, which is 6 (627003137)
	ADD X9, X9, #6
	ADD X10, XZR, XZR // Initialize X10 with 0, i = 0
	ADD X12, XZR, XZR // Initialize X12 with 0, will be used for offset
	MOV X11, X12 // Will be used in offset
loop:	SUBS XZR, X10, #10
	B.GE End_Loop // If i GE 10, break loop
	STR X9, [X0, X11] // else, store X9 in array with offset of X11, my_array[i] = j
	ADD X9, X9, #1 // Increment digit of UIN, j++
	ADD X12, X12, #4 // increment X12 becaues a word is 4 bytes
	MOV X11, X12 // Moves that value to X11
	ADD X10, X10, #1 // Increment X10, i++
	B loop // loop back
End_Loop: // outside of loop
	BR X30

.section .data
my_array:	.space 40 // initialize my array with capacity of words of size 10
