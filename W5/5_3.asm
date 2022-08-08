.data
prompt: .asciiz "\nNhap vao so nguyen: "
result: .asciiz "You entered: " 
printf_newline: .asciiz "\n"
.text
main:
	la $a0,prompt
	jal PrintString
	li $v0,5
	syscall
	move $s0,$v0
	
	jal PNL
	la $a0,result
	jal PrintString
	li $v0,1
	move $a0,$s0
	syscall
	
	jal Exit
	
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
