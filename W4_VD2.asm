.data
output1: .asciiz "\nInput a: "
output2: .asciiz "\nInput value: "
output3: .asciiz "\nPhep xor dau: "
output4: .asciiz "\nPhep xor cuoi: "

.text
.globl main
main: 
	li $v0,4
	la $a0,output1
	syscall
	
	ori $v0,$zero,5
	syscall
	move $s0,$v0
	
	li $v0,4
	la $a0,output2
	syscall
	
	li $v0,34
	move $a0,$s0
	syscall
	
	ori $v0,$zero,4
	la $a0,output3
	syscall
	
	xori $s0,$s0,0xffffffff
	move $a0,$s0
	
	ori $v0,$zero,34
	syscall
	
	ori $v0,$zero,4
	la $a0,output4
	syscall
	
	xori $s0,$s0,0xffffffff
	move $a0,$s0
	
	li $v0,,34
	syscall
	
	li $v0,10
	syscall
	
	