.data
num: .word -5
PositiveNumber: .asciiz "Number is Positive"
NegativeNumber: .asciiz "Number is Negative"
.include "TV.asm"
.text
	lw $t0,num # load num vao thanh ghi $t0
	sgt $t1,$t0,$zero # So sanh gia tri trong thanh ghi $t0 voi 0
	# Neu lon hon 0 thi $t1 = 1 va $t1 = 0 neu nguoc lai
	beqz $t1,else # Neu dung thi chay tiep khoi lenh duoi, neu sai thi nhay den nhan
		la $a0,Positive
		li $v0,4
		syscall
		b end_if
	else:
		la $a0,NegativeNumber
		jal PrintString
	end_if:
	jal Exit