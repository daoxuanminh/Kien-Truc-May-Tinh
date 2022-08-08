.data
mss: .asciiz "So lon nhat la: "
.text
main: 
	li $a0,30	# Tham so dau vao thu 1 cua chuong trinh
	li $a1,16	# Tham so dau vao thu 2 cua chuong trinh
	li $a2,90	# Tham so dau vao thu 3 cua chuong trinh
	jal max		# Nhay den ham max
	move $s0,$v0	# Chuyen maxtu $v0 vao $s0
	la $a0,mss
	addi $a1,$v0,0
	addi $v0,$0,56
	syscall
	jal Exit	# Thoat chuong trinh
max:
	add $v0,$a0,$0	# Luu gia tri tham so thu nhat vao $v0
	sub $t0,$a1,$v0	# $t0 la bien trung gian de so sanh bang so tiep theo tru cho max hien tai
	bltz $t0,okay	# Neu so tiep theo tru max hien tai nho hon 0 thi nhay den okay tuc la max van la lon nhat
	nop
	add $v0,$a1,$0	# Cap nhat lai max bang so hien tai
okay:	
	sub $t0,$a2,$v0	# Lay ra so thu 3 va dem tru cho max hien tai
	bltz $t0,done 	# So sanh thuong cua phep tru vua lam neu ket qua nho hon 0 thi hoan thanh max ko bi thay doi
	nop
	add $v0,$a2,$0	# Nguoc lai neu ko thi phai cap nhat lai max
done:
	jr $ra 		# Nhay ve ham main
# ---------------------------
# *** Chu y ***
# Cac thao tac nhay khi so sanh se khong lam thay doi thanh ghi $ra
.include "utils.asm"
