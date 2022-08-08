.data
	result1: .asciiz "Sum of "
	result2: .asciiz " and "
	result3: .asciiz " is "
	
.text
	li $s0, 5
	li $s1, 7
	add $t0, $s0, $s1
	li $v0, 4
	la $a0, result1
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, result2
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	