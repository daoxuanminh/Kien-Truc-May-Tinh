

.text
PrintInt:
	li $v0,4
	syscall
	move $a0,$a1
	li $v0,1
	syscall
	move $t0,$ra
	jal printf_newline
	move $ra,$t0
	jr $ra
.text
PNL:
	li $v0,4
	la $a0,printf_newline
	syscall
	jr $ra
.text
Exit:
	li $v0,10
	syscall
.text 
PrintString:
	addi $v0,$zero,4
	syscall
	jr $ra
.data
printf_newline: .asciiz "\n"
