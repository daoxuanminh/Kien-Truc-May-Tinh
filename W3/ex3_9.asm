.data 
prompt1: .asciiz  "Enter a value of n: "
prompt2: .asciiz  "\nEnter a value of T: "
prompt3: .asciiz  "\nEnter a value of P: "
output: .asciiz  "\nV = "
.text
main:
	#print prompt1
	addi $v0, $zero,4
	la $a0, prompt1
	syscall
	#read n
	li $v0, 5
	syscall
	move $s0,$v0
	#print prompt2
	addi $v0, $zero,4
	la $a0, prompt2
	syscall
	#read T
	li $v0, 5
	syscall
	move $s1,$v0
	#print prompt3
	addi $v0, $zero,4
	la $a0, prompt3
	syscall
	#read P
	li $v0, 5
	syscall
	move $s2,$v0
	#define R
	li $s3,8314
	li $s4,1000
	#tinh v
	mul $t0,$s0,$s1 # $t0 = n*T
	mul $t0, $t0,$s3 # $t0 = n*T*8314
	div $t0, $t0,$s2 # $t0 = n*T*8314/P
	div $t0,$t0,$s4 # $t0 = n*T *8314/P /1000
	
	addi $v0, $zero,4
	la $a0, output
	syscall
	
	addi $v0, $zero,1
	move $a0, $t0
	syscall
	
	li $v0,10
	syscall
	
	
	