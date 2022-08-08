.text
.globl main
main: 
	la $a0,prompt1
	jal PromptInt
	move $s0,$v0
	
	la $a0,prompt2
	jal PromptInt
	move $s1,$v0
	
	move $a0,$s0
	move $a1,$s1
	
	jal Multiply
	move $s2,$v0
	
	
	la $a0,result
	move $a1,$s2
	jal PrintInt
	jal Exit
	
Multiply: 
	addi $sp,$sp,-8
	sw $a0,4($sp)
	sw $ra,0($sp)
	
	seq $t0,$a1,$zero
	addi $v0,$zero,0
	bnez $t0,Return
	
	addi $a1,$a1,-1
	jal Multiply
	lw $a0,4($sp)
	add $v0,$a0,$v0
	
	Return: 
	lw $ra ,0($sp)
	addi $sp,$sp,8
	jr $ra
.data
prompt1: .asciiz "Enter the multiplicand: "
prompt2: .asciiz  "Enter the multiplier: "
result: .asciiz "The answer is : "
.include "utils.asm"