.text
.globl main
main:
	jal GoodSubprogram
	la $a0, string3
	jal PrintString
	jal Exit
	
GoodSubprogram:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,string1
	jal PrintString
	
	li $v0,4
	la $a0,string2
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr  $ra
	
.data
string1: .asciiz "/nIn SubProgram GoodExample\n"
string2: .asciiz "After call to PrintString\n"
string3: .asciiz "After call GoodExample\n"

.include "utils.asm"
