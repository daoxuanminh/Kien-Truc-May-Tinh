.data
cmt: .asciiz "Nhap vao gia tri x: "
result: .asciiz "Result: "

.text
main: 
	li $v0,4
	la $a0,cmt
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	mul $s1,$s0,$s0
	mul $s1,$s1,5
	mul $s2,$s0,2
	add $s0,$s1,$s2
	add $s0,$s0,3
	move $a0,$s0
	li $v0,1
	syscall
	
	
	