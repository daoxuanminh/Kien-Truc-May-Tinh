# Bat nguoi dung nhap vao 3 gia tri roi tinh trung binh
.data
mss: .asciiz "Nhap vao 3 gia tri!\n"
mss1: .asciiz "Nhap gia tri: "
mss2: .asciiz "Ket qua trung binh: " 
.text
main:
	la $a0,mss
	jal PrintString
	li $t0,3 	# Bien dem cho vong lap for
	loop:
		beqz $t0,end_loop
		la $a0,mss1
		jal PromptInt
		addi $sp,$sp,-4
		sw $a0,0($sp)
		addi $t0,$t0,-1
		jal loop
	end_loop:
	li $t0,3 
	addi $s0,$0,0	# Thanh ghi $s0 luu trung binh
	loop1:
		beqz $t0,end_loop1
		lw $v0,0($sp)
		addi $sp,$sp,4
		add $s0,$s0,$v0
		addi $t0,$t0,-1
		jal loop1
	end_loop1:
	div $a1,$s0,3
	la $a0,mss2
	jal PrintInt
	jal Exit
end_main:


		
.include "utils.asm"
