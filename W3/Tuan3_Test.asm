.data 
prompt: .asciiz "Enter your number: "
result: .asciiz "Neu ket qua la 0 thi la so chan, la 1 thi la so le. Ket qua: "

.text
main:
	li $v0,4
	la $a0,prompt
	syscall 
	
	li $v0,5
	syscall
	move $s0,$v0
	
	rem $t0,$s0,2
	li $v0,4
	la $a0,result
	syscall
	
	li $v0,1
	move $a0,$t0
	syscall