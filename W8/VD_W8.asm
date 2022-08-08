.data
a: .word 5
b: .word 2
c: .word 3
y: .word 0
prompt: .asciiz "Enter a value for x: "
result: .asciiz "The result is: "
.text
.globl main
main:
	la $a0,prompt
	jal PromptInt
	move $s0,$v0
	
	lw $t5,a
	lw $t6,b
	lw $t7,c
	
	jal Exit
.include "utils.asm"