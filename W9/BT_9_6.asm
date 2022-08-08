.text
main:
	addi $s0,$0,2
	addi $s1,$0,5
push:
	addi $sp,$sp,-8
	sw $s0,0($sp)
	sw $s1,4($sp)
work:
	nop
	nop 
	nop
pop:	
	lw $s0,4($sp)
	lw $s1,0($sp)
	addi $sp,$sp,8