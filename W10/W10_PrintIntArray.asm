.text
.globl main
main:
	la 	$a0,array_base
	la	$a1,array_size
	jal	PrintIntArray
	jal 	Exit
.data
	array_size: .word 5
	array_base:
		.word 12
		.word 7
		.word 3
		.word 5
		.word 11
		
.text
PrintIntArray:
	addi 	$sp,$sp,-16
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	sw	$s1,8($sp)
	sw	$s2,12($sp)
	
	move 	$s0,$a0
	move 	$s1,$a1
	move 	$s2,$0
	
	la 	$a0,open_bracket
	jal	PrintString
	
loop:
	sge	$t0,$s2,$s1
	bnez	$t0,end_loop
		sll	$t0,$s2,2
	
		add 	$t0,$t0,$s0
		lw	$a1,0($t0)
		la	$a0,comma
		jal	PrintInt
	
		addi	$s2,$s2,1
		b 	loop
end_loop:

	li	$v0,4
	la	$a0,close_bracket
	syscall
	
	lw 	$ra,0($sp) 	
	lw 	$ra,0($sp)
	lw 	$ra,0($sp)
	lw 	$ra,0($sp)
	addi	$sp,$sp,16
	jr	$ra
.data
	close_bracket:	.asciiz "]"
	open_bracket:	.asciiz "["
	comma:	.asciiz ","
	
.include "utils.asm"
	
