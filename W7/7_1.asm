.data
y: .word 0
prompt: .asciiz "Enter a values for x: "
result: .asciiz "Result is: "
.text
.globl main

main:
	la $a0,prompt
	nop
	jal PromptInt
	nop 
	move $s0,$v0
	
	li $t5,5
	li $t6,2
	li $t7,3
	nop
	
	mul $t0,$s0,$s0
	nop
	mul $t0,$t0,$t5
	nop
	mul $t1,$s0,$t6
	nop
	add $t0,$t0,$t1
	nop
	add $s1,$t0,$t7
	nop
	
	la $a0, result
	move $a1,$s1
	jal PrintInt
	jal PrintNewLine
	jal Exit
	
.include "utils.asm"
