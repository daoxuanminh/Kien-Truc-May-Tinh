.data
input: .space 81
inputSize: .word 80
prompt: .asciiz "Enter your favorite bread: "
output1: .asciiz "So you like "
output2: .asciiz "pie"

.text
main:
	#print prompt
	li $v0,4
	la $a0,prompt
	syscall
	#read bread
	li $v0,8
	la $a0,input
	lw $a1, inputSize
	syscall
	#print output1
	li $v0,4
	la $a0,output1
	syscall
	#print type bread
	li $v0,4
	la $a0,input
	syscall
	#print pie
	li $v0,4
	la $a0,output2
	syscall
	#exit
	li $v0,10
	syscall
#khong the in cung dong do dia chi cua chuoi duoc ket thuc = null. nen se xuong dong