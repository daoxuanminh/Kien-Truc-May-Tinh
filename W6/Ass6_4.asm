.data
	result1: .asciiz "sum = "
 	array: .word 0, 1, 2, 3, 4, 5, 6, 7
.text
	li $s1, 0x00000000  
	li $s3, 0x00000005
	li $s4, 0x00000001  
	li $s5, 0x00000000
	la $s2, array
	
loop: 
	
	add $s1, $s1, $s4		# i = i + step
	add $t1, $s1, $s1		# t1 = 2 * s1
	add $t1, $t1, $t1		# t1 = 4 * t1
	add $t1, $t1, $s2		# t1 store the address of A[i]
	lw $t0, 0($t1)			# load value of A[i] in $t0
	add $s5, $s5, $t0		# sum = sum + A[i]
	
#	bne $s1, $s3, loop 		# if i != n, goto loop
	
#	blt $s1, $s3, loop		# if i < n, goto loop

#	ble $s1, $s3, loop		# if i <= n, goto loop

#	bge $s5, $zero, loop		# if sum >= 0, goto loop

#	beq $t0, $zero, loop 		# if A[i] == 0, goto loop


end:
	la $a0, result1
	li $v0, 4
	syscall 
	move $a0, $s5
	li $v0, 1
	syscall
	jal Exit
	
.include "utils.asm"
