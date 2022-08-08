.text 
main:
	li $v0, 4
	la $a0, result1
	syscall
	
	li $v0,1  #thay 4 -> 1. in 1 so nguyen 
	li $a0,4
	syscall
	
	li $v0,4
	la $a0,result2
	syscall
	
	li $v0,1
	li $a0, 8
	syscall 
	
	addi $v0, $zero, 10
	syscall
	
.data 
result1: .asciiz  "\n first value = "
result2: .asciiz  "\n second value = "