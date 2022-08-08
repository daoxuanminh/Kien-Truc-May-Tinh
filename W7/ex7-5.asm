
.data
	message: .asciiz "Please input a string: "
	string: .space 100
	result: .asciiz "Length of string: "
	
.text
main:
get_string:
	li $v0, 54
	la $a0, message
	la $a1, string
	la $a2, 100	
	syscall
	xor $v0, $zero, $zero			# v0 = length = 0
	xor $t0, $zero, $zero			# t0 = i = 0
	
check_char:
	la $a0, string
	add $t1, $a0, $t0			# t1 = a0 + t0
						# = Address(string[0] + i)
	lb $t2, 0($t1)				# t2 = string[i]
	beq $t2, $zero, end_of_str		# Is null char?
	addi $v0, $v0, 1			# v0 = v0 + 1 -> length = length + 1
	addi $t0, $t0, 1			# t0 = t0 + 1 -> i = i + 1
	j check_char
	
end_of_str:
	addi $s0, $v0, 0
	sub $s0, $s0, 1
	
print_length:	

	move $a1, $s0
	li $v0, 56
	la $a0, result
	syscall 
	jal Exit			

.include "utils.asm"
