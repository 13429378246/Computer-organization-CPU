# Piece 2-12
.data
str: .ascii "\nWelcome "
sid: .space 9
e1: .asciz " to RISC-V World"
.text
main:

li a7, 8 # to get a string
la a0, sid
li a1, 9
ecall
 
#complete code here

la t0, sid
addi t0, t0, 8
la t1, e1

loop:
	lb t2, (t1)
	sb t2, (t0)
	addi t1, t1, 1
	addi t0, t0, 1
	bnez t2, loop 

li a7, 4 # to print a string
la a0, str
ecall

li a7, 10 # to exit
ecall