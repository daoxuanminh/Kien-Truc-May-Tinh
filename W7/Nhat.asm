.data
	string: .space 40
	mes: .asciiz "\n Nhap vao 1 chuoi: "
	mes1: .asciiz "\n Do dai chuoi la: "
.text
GetString:
	li $v0, 54
	la $a0, mes
	la $a1, string
	la $a2, 100
	syscall
	la $a1,string
	move $s1,$a1
	
GetLength:
	li $s0, 0      #length = 0
	li $t0, 0      #index = 0
CheckChar:
	add $t1, $a1, $t0
	
	lb $t2, 0($t1)
	beq $t2, $zero, EndofStr
	addi $s0, $s0, 1         #length
	addi $t0, $t0, 1         #index
	j CheckChar
EndofStr:

EndofGetLength:

PrintLength:
	
	addi $s0,$s0,-1
	li $v0, 56
	la $a0, mes1
	add $a1,$zero,$s0
	syscall
	
	jal Exit
.include "utils.asm"