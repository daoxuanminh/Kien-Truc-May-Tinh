.data
output1: .asciiz "Please enter the value of n: "
output2: .asciiz "Number n is prime"
output3: .asciiz "Number n is not prime"

.text
	ori $v0,$zero,4			#Print output1
	la $a0,output1
	syscall
	
	ori $v0,$zero,5			#Read input a from user
	syscall
	move $t0, $v0
	
	li $s0, 1			#Initialize 
	li $s1, 1
	
loop:	
	add $s0, $s0, $s1		#check if prime or not
	beq $s0, $t0, yes
	rem $t1, $t0, $s0
	bne $t1, $zero, loop
	j no
	
yes:
	ori $v0,$zero,4			#if prime then print output2
	la $a0,output2
	syscall
	jal Exit
	
no: 
	ori $v0,$zero,4			#if not then print output3
	la $a0,output3
	syscall
	jal Exit
	
.include "utils.asm"
	

	
	