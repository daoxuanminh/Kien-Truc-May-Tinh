
.text

start_1: 
	slt $t0, $s1, $s2		# i < j
	bne $t0, $zero, else_1		# branch to else if i < j
	addi $t1, $t1, 1		# then part: x = x + 1
	addi $t3, $zero, 1		# z = 1
	j endif_1 			# skip "else" part
else_1: 
	addi $t2, $t2, -1		# begin else part: y = y - 1
	add $t3, $t3, $t3		# z = 2 * z
endif_1:
	jal Exit


start_2: 
	slt $t0, $s1, $s2		# i >= j
	beq $t0, $zero, else_2		# branch to else if i >= j
	addi $t1, $t1, 1		# then part: x = x + 1
	addi $t3, $zero, 1		# z = 1
	j endif_2 			# skip "else" part
else_2: 
	addi $t2, $t2, -1		# begin else part: y = y - 1
	add $t3, $t3, $t3		# z = 2 * z
endif_2:
	jal Exit


start_3: 
	add $s3, $s1, $s2
	sgt $t0, $s3, $zero		# i + j <= 0
	beq $t0, $zero, else_3		# branch to else if i + j <= 0
	addi $t1, $t1, 1		# then part: x = x + 1
	addi $t3, $zero, 1		# z = 1
	j endif_3			# skip "else" part
else_3: 
	addi $t2, $t2, -1		# begin else part: y = y - 1
	add $t3, $t3, $t3		# z = 2 * z
endif_3:
	jal Exit


start_4: 
	ori $v0,$zero,5			#Read m from user
	syscall
	move $s4,$v0
	ori $v0,$zero,5			#Read n from user
	syscall
	move $s5,$v0
	
	add $s6, $s4, $s5
	add $s3, $s1, $s2
	sgt $t0, $s3, $s6		# i + j > m + n
	bne $t0, $zero, else_4		# branch to else if i + j > m + n
	addi $t1, $t1, 1		# then part: x = x + 1
	addi $t3, $zero, 1		# z = 1
	j endif_4 			# skip "else" part
else_4: 
	addi $t2, $t2, -1		# begin else part: y = y - 1
	add $t3, $t3, $t3		# z = 2 * z
endif_4:
	jal Exit


.include "utils.asm"
