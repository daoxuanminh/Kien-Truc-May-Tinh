.data
	result1: .asciiz "a = "
	result2: .asciiz "\nb = "
	result3: .asciiz "There is no matching result!"
	test: .word 3
	
.text
	li $s2, 1
	li $s3, 1
	
	la $s0, test 		# load the address of the test variable
	lw $s1, 0($s0)		# load the value of test to register $t1
	li $t0, 0		# load value for test case
	li $t1, 1
	li $t2, 2
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	j default
	
case_0:
	addi $s2, $s2, 1	# a = a + 1
	j continue
	
case_1: 
	sub $s2, $s2, $t1	# a = a - 1
	j continue
	
case_2: 	
	add $s3, $s3, $s3	# b = 2 * b
	j continue
	
default:
	la $a0, result3
	li $v0, 4
	syscall 
	jal Exit
	
continue:
	la $a0, result1
	li $v0, 4
	syscall 
	move $a0, $s2
	li $v0, 1
	syscall
	la $a0, result2
	li $v0, 4
	syscall 
	move $a0, $s3
	li $v0, 1
	syscall
	jal Exit
	
.include "utils.asm"
	

	
	
