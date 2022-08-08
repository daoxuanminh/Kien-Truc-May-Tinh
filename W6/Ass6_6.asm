.text 
	li $s1 , 3
	li $s2 , 5
START:
	li $t0 , 0				#Check
	addu $s3 , $s1 , $s2			#$s3 = $s2 + $s1
	xor $t1 , $s1 , $s2			#$s1 XOR $s2 to check 
						#if $s1 has the same sign as $s2
	
	bltz $t1 , EXIT				#If not, jump to EXIT
	slt $t2 , $s3 , $s1			#if $s3 < $s1 -> $t2 = 1, else $t2 = 0
	bltz $s1 , NEGATIVE			#If $s1 < 0, jump to NEGATIVE 
	beq $t2 , $zero , EXIT			#If $s1 > 0 && $s3 > $s1, jump to EXIT
	j OVERFLOW				#Jump to OVERFLOW
	
NEGATIVE :
	bne $t2 , $zero , EXIT			#If $s3 < $s1 -> $t2 = 1 -> jump to EXIT
	
OVERFLOW:
	li $t0 , 1
EXIT:
	addi $v0, $zero, 10			#Exit
	syscall
	
	