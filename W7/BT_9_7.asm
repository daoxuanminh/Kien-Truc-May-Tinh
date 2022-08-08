.text
main:	# Du lieu dau vao
	addi $a0,$0,0
	addi $a1,$0,4
	addi $a2,$0,2
	addi $a3,$0,6
	jal Find_Max_Adv
	la $a0,mss1
	move $a1,$v0
	jal PrintInt
	la $a0,mss2
	move $a1,$v1
	jal PrintInt
	jal Exit
Find_Max_Adv:
	add $v1,$a0,$a1
	add $v1,$v1,$a2
	add $v1,$v1,$a3
	div $v1,$v1,4
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal getMax	# So sanh $a0,$a1
	move $s0,$v0	# Tra ve gia tri max 2 so cho thanh ghi $s0
	move $a0,$s0
	move $a1,$a2
	jal getMax	# So sanh $s0,$a2
	move $s0,$v0	# Tra ve gia tri max 2 so cho thanh ghi $s0
	move $a0,$s0
	move $a1,$a3
	jal getMax	# So sanh $s0,$a3
	move $s0,$v0	# Tra ve gia tri max 2 so cho thanh ghi $s0
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
getMax:	# Tham so dau vao se la 2 thanh ghi $a0,$a1
	move $v0,$a0
	bge $v0,$a1,return
	move $v0,$a1
	jr $ra
return:
	jr $ra
.include "utils.asm" 
.data
mss1: .asciiz "Max: "
mss2: .asciiz "Adv: "
