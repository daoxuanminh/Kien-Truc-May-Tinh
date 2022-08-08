.data
	open_bracket: .asciiz "[" 
	close_bracket: .asciiz "]" 
	comma: .asciiz ","
.text
main:
	la $a0, array_base        # dia chi cac phan tu trong mang
	lw $a1, array_size        # kích thý?c m?ng (n)
	jal PrintIntArray
	jal Exit
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
	addi $sp, $sp, -16 #L?y 16 byte (0-15)làm ngãn x?p lýu d? li?u 
	sw $ra, 0($sp)		# ra lýu t? 0-3
	sw $s0, 4($sp)		# s0 lýu t? 4-7
	sw $s1, 8($sp)		# s1 lýu t? 8-11
	sw $s2, 12($sp)         # s2 lýu t? 12-15

	move $s0, $a0		# move base to s0
	
	move $s2, $a1		# move n to s2
	addi $s2, $s2, -1         # bien dem i = s2
	la $a0, open_bracket 
	jal PrintString
loop: 
	slt $t0, $s2, $zero	# if s2 < 0 then t0 = 1 else t0 = 0
	bnez $t0, end_loop      # if t0 = 1 then return end; else continue
		
		sll $t0, $s2, 2         # dich phai s2 2 bit va lýu vào t0
					# t0 = s2 * 4 ( v? m?i ph?n t? cách nhau 4 bit)
		add $t0, $t0, $s0       # d?a ch? c?a ph?n t? ti?p theo
		
		lw $a1, 0($t0) 		# l?y ph?n t? ti?p theo và lýu vào a1
		la $a0, comma		
		jal PrintInt
		
		addi $s2, $s2, -1        # i = i - 1
		b loop
end_loop:
	li $v0, 4
	la $a0, close_bracket
	syscall

	lw $ra, 0($sp)                # tr? v? các thanh ghi
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16

	jr $ra
	
.include "utils.asm"
