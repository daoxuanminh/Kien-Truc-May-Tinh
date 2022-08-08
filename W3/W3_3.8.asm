.data
x: .asciiz "Nhap x = "
y: .asciiz "Nhap y = "
z: .asciiz "Nhap z = "
a: .asciiz "\n5x+3y+z="
b: .asciiz "\n((5x+3y+z)/2)*3="
c: .asciiz "\nx^3+2x^2+3x+4="
d: .asciiz "\n(4x/3)*y="

.text
main: 
# Nhap so
	li $v0,4
	la $a0,x
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	
	li $v0,4
	la $a0,y
	syscall
	
	li $v0,5
	syscall
	move $s2,$v0
	
	li $v0,4
	la $a0,z
	syscall
	
	li $v0,5
	syscall
	move $s3,$v0
# Cau a
	li $v0,4
	la $a0,a
	syscall
	
	mul $t0,$s1,5
	mul $t1,$s2,3
	add $t0,$t0,$t1
	add $t0,$t0,$s3
	
	li $v0,1
	move $a0,$t0
	syscall
	
	
	
#Cau b	
	li $v0,4
	la $a0,b
	syscall
	
	mul $t0,$t0,3
	div $a0,$t0,2
	
	li $v0,1
	syscall
#Cau c	
	li $v0,4
	la $a0,c
	syscall
	
	mul $t1,$s1,$s1
	mul $t0,$t1,$s1
	mul $t1,$t0,2
	mul $t2,$s1,3
	add $t0,$t0,$t1
	add $t0,$t0,$t2
	add $t0,$t0,4
	move $a0,$t0
	
	li $v0,1
	syscall
#Cau d
	li $v0,4
	la $a0,d
	syscall
	mul $t0,$s1,4
	mul $t0,$t0,$s2
	div $a0,$t0,3
	
	li $v0,1
	syscall
	
