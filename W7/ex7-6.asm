
.data
	string1: .space 20
	string2: .space 20
	input: .asciiz "Please enter a string: "
	output: .asciiz "The reversed string: "
	
.text
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 8
	la $a0, string1
	li $a1, 20
	syscall
	
get_length:
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
  	sub $s0, $s0, 1
	add $t1, $zero, $s0			# Save string length to $t1
	add $t2, $zero, $a0			# Save input string to $t2

reverse:
	li $t0, 0			
	li $t3, 0			
	
reverse_loop:
	add $t3, $t2, $t0			# $t2 is the base address for 'string1' array, add loop index
	lb $t4, 0($t3)				# Load a byte at a time according to counter
	beqz $t4, exit				# Found the null-byte
	sb $t4, string2($t1)			# Overwrite this byte address in memory	
	subi $t1, $t1, 1			# Subtract overall string length by 1 (j--)
	addi $t0, $t0, 1			# Advance counter (i++)
	j reverse_loop				# Loop until reaching the condition
	
exit:
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 4				# Print string2
	la $a0, string2		
	syscall
	jal Exit
	
.include "utils.asm"
