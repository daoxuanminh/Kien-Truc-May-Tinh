.data
	o1: .asciiz "Nhap so tu 0 den 15:  "
	o2: .asciiz "\nSo vua nhap chuyen sang he 16 la: "
	a:  .asciiz "A"
	b1:  .asciiz "B"
	c: .asciiz "C"
	d: .asciiz "D"
	e: .asciiz "E"
	f: .asciiz "F"
	else: .asciiz "Vui long doc ky de bai"
.text
main:
	la $a0, o1
	jal PromptInt
	
	move $s0, $v0
	
	sge $t0, $s0, 10
	bnez $t0, Chu
	 jal So
So:
	la $a0, o2
	move $a1, $s0
	jal PrintInt
	jal Exit
Chu:	
	la $a0, o2
	jal PrintString
	
	sge $t0, $s0, 11
	bnez $t0, Chu1
		la $a0, a
		jal PrintString
		jal Exit
	Chu1:
	sge $t0, $s0, 12
	bnez $t0, Chu2
		la $a0, b1
		jal PrintString
		jal Exit
	Chu2:
	sge $t0, $s0, 13
	bnez $t0, Chu3
		la $a0, c
		jal PrintString
		jal Exit
	Chu3:
	sge $t0, $s0, 14
	bnez $t0, Chu4
		la $a0, d
		jal PrintString
		jal Exit
	Chu4:
	sge $t0, $s0, 15
	bnez $t0, Chu5
		la $a0, e
		jal PrintString
		jal Exit
	Chu5:
	sge $t0, $s0, 16
	bnez $t0, End
		la $a0, f
		jal PrintString
		jal Exit
	End:
	la $a0, else
	jal PrintString 
	jal Exit
.include "utils.asm"
	
	
	
	
	
	