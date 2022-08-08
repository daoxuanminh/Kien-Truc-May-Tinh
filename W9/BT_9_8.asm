.text
PrintInt:
	li $v0,4
	syscall
	move $a0,$a1
	li $v0,1
	syscall
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal PrintNewLine
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra