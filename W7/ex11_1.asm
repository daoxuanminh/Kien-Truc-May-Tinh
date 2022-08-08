.eqv SEVENSEG_LEFT    0xFFFF0011
.eqv SEVENSEG_RIGHT   0xFFFF0010
.data
	arr_size: .word 16
	arr_base: 
		.word 0x3f
		.word 0x06
		.word 0x5b
		.word 0x4f
		.word 0x66
		.word 0x6d
		.word 0x7d
		.word 0x07
		.word 0x7f
		.word 0x6f
		.word 0x77
		.word 0x7c
		.word 0x39
		.word 0x5e
		.word 0x79
		.word 0x71
.text
main:
	la $s0,arr_base 
	lw $s1 , arr_size
	la $s2,SEVENSEG_RIGHT
	
	addi $t0,$zero,-1
	loop:
	addi $t0,$t0,1
	beq $t0,$s1,continue
	sll $t1,$t0,2
	add $t1,$t1,$s0
	
	lw $t1,0($t1)
	sb $t1,0($s2)
	
	beq $t0,$s1,continue
	
	li $v0,32
	li $a0, 600
	syscall
	j loop	
	
	 
	 continue: 
	 jal Exit
.include "utils.asm"
