
.data
	string: .asciiz "hello world"
	y: .space 1000			# destination string x, empty
	result1: .asciiz "\nString ends!"
	result2: .asciiz "\nLength of string: "
	result3: .asciiz "String y: "
	
.text
main:
get_string:	
	add $s0, $zero, $zero		# s0 = i = 0
	la $a0, string			# a0 = Address(string[0])
	la $a1, y

L1:
	add $t1, $s0, $a0		# t1 = s0 + a1 = i + y[0]
					# = addresee of y[i]
	lb $t2, 0($t1)			# t2 = value of t1 = y[i]
	add $t3, $s0, $a1		# t3 = s0 + a0 = i + x[0]
					# = address of x[i]
	sb $t2, 0($t3)			# x [i] = t2 = y[i]
	beq $t2, $zero, end_of_strcpy	# if y[i] == 0, exit
	nop
	addi $s0, $s0, 1		# s0 = s0 + 1 <-> i = i + 1
	j L1				# next character
	nop		

end_of_strcpy:
	la $a0, result3
	li $v0, 4
	syscall 
	la $a0, y
	li $v0, 4
	syscall 
					
get_length:
	add $s0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	xor $v0, $zero, $zero			# v0 = length = 0
	xor $t0, $zero, $zero			# t0 = i = 0
	
check_char:
	add $t1, $a0, $t0			# t1 = a0 + t0
						# = Address(string[0] + i)
	lb $t2, 0($t1)				# t2 = string[i]
	beq $t2, $zero, end_of_str		# Is null char?
	addi $v0, $v0, 1			# v0 = v0 + 1 -> length = length + 1
	addi $t0, $t0, 1			# t0 = t0 + 1 -> i = i + 1
	j check_char
	
end_of_str:
	addi $s0, $v0, 0
	
end_of_get_length:
	la $a0, result1
	li $v0, 4
	syscall 
	
print_length:	
	la $a0, result2
	li $v0, 4
	syscall 
	move $a0, $s0
	li $v0, 1
	syscall	
	jal Exit			

.include "utils.asm"
