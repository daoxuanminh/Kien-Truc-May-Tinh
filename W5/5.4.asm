.data
prompt: .asciiz "\nNhap vao so nguyen: "
result: .asciiz "You entered: " 

.text
main:
	la $a0,prompt
	jal PrintString
	li $v0,5
	syscall
	move $s0,$v0
	
	jal PNL
	la $a0,result
	move $a1,$s0
	jal PrintInt
	
	jal Exit

.include "TV.asm"


