.text
.globl main
	# Get input value and store it in $s0
main: 
	la $a0, prompt
	jal PromptInt
	nop
	nop
	move $s0, $v0
	
	# Load constants a, b and c into registers
	li $t5, 5
	li $t6, 2
	li $t7, 3
	
	# Calculate the result of 
	# y = a*x*x + b*x + c and store it
	mul $t0, $s0, $s0
	nop
	nop
	mul $t0, $t0, $t5
	nop
	nop
	mul $t1, $s0, $t6
	nop
	nop
	add $t0, $t0, $t1
	nop
	nop
	add $s1, $t0, $t7
	
	# Print output from memory y
	la $a0, result
	move $a1, $s1
	nop
	nop
	jal PrintInt
	nop
	jal PrintNewLine
	nop
	
	# Exit program
	jal Exit
	nop
	
.data
	y: .word 0
	prompt: .asciiz "Enter a value for x: "
	result: .asciiz "The result is: "
	
.include "utils.asm"


