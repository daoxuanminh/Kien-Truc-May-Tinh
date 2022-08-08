.data
n: .asciiz "Nhap n: "
t: .asciiz "Nhap T: "
p: .asciiz "Nhap P: "
result: .asciiz "Ket qua = "
.text 
main: 
	#Nhap du lieu n,P,T
	li $v0,4	#Nhap n
	la $a0,n
	syscall
	
	li $v0,5	
	syscall
	move $s0,$v0 
	
	li $v0,4	#Nhap P
	la $a0,p
	syscall
	
	li $v0,5	
	syscall
	move $s1,$v0
	
	li $v0,4	#Nhap T
	la $a0,t
	syscall
	
	li $v0,5
	syscall
	move $s2,$v0
	
	#Tinh toan
	
	li $v0,4	#In ra string Result
	la $a0,result
	syscall
	
	li $t0,8314
	div $t0,$t0,1000
	mul $t0,$t0,$s1
	mul $t1,$s0,$s2
	
	
	
	