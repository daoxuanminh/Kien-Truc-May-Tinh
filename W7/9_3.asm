.text 
main:
	jal 	Warp
print: 	add 	$a1,$v0,$0
	li 	$v0,56
	la 	$a0,Message
	syscall
	jal 	Exit
endmain:

Warp:	
	sw	$fp,-4($sp)
	addi 	$fp,$sp,0
	addi 	$sp,$sp,-8
	sw 	$ra,0($sp)
	
	li 	$a0,3	# Dau vao nhap o day
	jal 	Fact
	nop
	
	lw 	$ra,0($sp)
	addi 	$sp,$fp,0
	lw 	$fp,-4($sp)
	jr	$ra
warp_end:
.data
Message: .asciiz "Ket qua: "
.include "utils.asm"
Fact:
	sw 	$fp,-4($sp)
	addi 	$fp,$sp,0
	addi	$sp,$sp,-12
	sw	$ra,4($sp)
	sw	$a0,0($sp)
	slti 	$t0,$a0,2
	beq	$t0,$0,recursive
	nop
	li	$v0,1
	j 	done
	nop
recursive:
	addi	$a0,$a0,-1
	jal	Fact
	nop
	lw 	$v1,0($sp)
	mult 	$v1,$v0
	mflo	$v0
done:
	lw	$ra,4($sp)
	lw 	$a0,0($sp)
	addi	$sp,$fp,0
	lw	$fp,-4($sp)
	jr 	$ra
	
