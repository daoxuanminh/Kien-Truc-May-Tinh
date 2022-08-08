#File: utils.asm
#Purpose: To define utilities which will be used in MIPS program
#Author: Dao Xuan Minh



.text
PromptInt:
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $a0,$v0
	nop
	nop
	jr $ra
	#nop
 #____________________________________________
.text
PrintNewLine:
	li $v0,4
	la $a0,_PNL_newline
	syscall
	jr $ra
.data
 _PNL_newline: .asciiz "\n"
 #____________________________________________
 .text 
 PrintTab:
	li $v0,4
	la $a0,tab
	syscall
	jr $ra
.data
	tab: .asciiz "\t"
#______________________________________________
 .text
 PrintString:
 	li $v0,4
	syscall
	jr $ra
#___________________________________________
.text
PrintInt:
	li $v0,4
	syscall
	move $a0,$a1
	li $v0,1
	syscall
	jr $ra
	#addi $sp,$sp,-4
	#sw $ra,0($sp)
	#jal PrintNewLine
	#lw $ra,0($sp)
	#addi $sp,$sp,4
	#jr $ra
#_____________________________________
.text
Exit:
	li $v0,10
	syscall
#_________________________
.text
result_Nor:
	nor $v0,$a1,$a2
	jr $ra
#________________________________
.text 
result_NAND:
	and $v0,$a1,$a2
	not $v0,$v0
	jr $ra
#_______________________________
.text
result_NOT:
	not $v0,$a1
	jr $ra
#______________________________
.text
result_Mult4:
	sll $v0,$a1,2
	jr $ra
#______________________________
.text
result_Mult10:
	sll $t0,$a1,3
	sll $t1,$a2,1
	add $v0,$t0,$t1
	jr $ra
#_______________________________
.text
result_swap:
	xor $t0,$a1,$a2
	xor $v0,$t0,$a1
	xor $v1,$t0,$a2
	jr $ra
#_______________________________-
.text
RightCircularShift: 
	andi $v1,$a1,0x00000001
	ror $v0,$a1,1
	jr $ra
#________________________________
.text 
LeftCircularShift:
	rol $v0,$a1,1
	andi $v1,$v0,0x00000001
	jr $ra
#___________________________
.text
To_Lower:
	ori $v0,$a1,0x00202020
	jr $ra
#____________________________
.text 
To_Upper: 
	andi $v0,$a1,0x00dfdfdf
	jr $ra
#____________________________	
.text
strcpy:
	#la 	$a1,y
	#la	$a0,x
	add 	$s0,$zero,0	# Bien danh chi so index
	strcpy_loop:
		add	$t1,$s0,,$a1	# Thanh ghi t1 luu dia chi cua y[i]
		lb 	$t2,0($t1)	# t2 la gia tri cua phan tu y[i]
		
		add 	$t3,$s0,$a0	# t3 luu dia chi cua x[i]
		sb 	$t2,0($t3)	# luu y[i] vao dia chi cua x[i]
		
		beq 	$t2,$0,end_of_strcpy	#So sanh neu là ky tu ket thuc thi nhay den ket thuc vong lap
		add 	$s0,$s0,1
		j 	strcpy_loop
	end_of_strcpy:
	jr $ra
#____________________________
.text
strlen:
	add 	$s0,$zero,0	# Bien danh chi so index	
	strlen_loop:
		add 	$t1,$s0,$a0	# t1 luu dia chi cua x[i]
		lb	$t2,0($t1)	# t2 luu gia tri x[i]
		beq 	$t2,$0,end_of_strlen	#So sanh neu la ky tu ket thuc thi nhay den ket thuc vong lap
		
		add 	$s0,$s0,1	# Tang bien dem s0
		j	strlen_loop
		end_of_strlen:
		add	$a0,$s0,0	# ham tra ket qua bang thanh ghi a0
		jr	$ra























	
