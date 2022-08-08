#File: utils.asm
#Purpose: To define utilities which will be used in MIPS program
#Author: Khanh Ngoc Dam
#
#SubPrograms Index: 
#Exit        - Call syscall 10 to exit the program
#NewLine     - Print \n 
#PrintString - Print string
#Modification - 9/5/2022
.text
PromptInt:
	li $v0,4
	syscall
	li $v0,5
	syscall
	jr $ra
#_________________________________________________________
PrintNewLine:
	li $v0,4
	la $a0,_PNL_newline
	syscall
	jr $ra
.data
 _PNL_newline: .asciiz "\n"
 #____________________________________________
# .text 
 #PrintTab:
#	li $v0,4
#	la $a0,tab
#	syscall
#	jr $ra
#.data
#	tab: .asciiz "\t "
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
	
	
	
