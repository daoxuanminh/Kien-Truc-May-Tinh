.data
input: .asciiz "Nhap so luong phan tu mang: "
output1: .asciiz "Max arr: "
output2: .asciiz "So phan tu thuoc khoang (m,M): "
arr: .word 0
.text
main:
	la $a0,input
	jal PromptInt
	move $s0,$v0
	jal Exit
.include "utils.asm"
