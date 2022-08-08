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
	
	lui $t0,0x1001
	lw $t5,0($t0)
	lw $t6,4($t0)
	lw $t7,8($t0)
	
	jal Exit
.include "utils.asm"