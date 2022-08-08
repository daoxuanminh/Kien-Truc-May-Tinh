.data
	messenger_1:		.asciiz		"Nhap bieu thuc can tinh: "
	messenger_2:		.asciiz		"Bieu thuc hau to la: "
	messenger_3:		.asciiz		"Ket qua sau cua bieu thuc hau to la: "
	messenger_4:		.asciiz		"Bieu thuc khong hop le!  Hay nhap lai bieu thuc!"
	A:					.space		1000
.text

data:
	addi	$t0, $zero, -43			# Phep Cong
	addi	$t1, $zero, -45			# Phep Tru
	addi	$t2, $zero, -42			# Phep Nhan
	addi	$t3, $zero, -47			# Phep Chia
	addi	$t4, $zero, -37			# Phep Chia Lay Du
	addi	$t5, $zero, -40			# Ngoac Mo
	addi	$t6, $zero, -41			# Ngoac Dong
	addi	$s3, $zero, -32			# Dau Cach
	addi	$s4, $zero, -10			# Enter, xuong dong
	addi	$s2, $zero, 10
	
Nhap_bieu_thuc:		# Ham nhap bieu thuc
	li		$v0, 54
	la		$a0, messenger_1
	la		$a1, A
	la		$a2, 1000
	syscall
	
	addi	$s0, $gp, 0				# Stack 1
	
	addi	$fp, $zero, 0			
	la		$t7, A					# Luu bieu thuc vua nhap vao $t7
	
Xet_Thanh_Phan:
	Read_Char:
		lb		$t8, 0($t7)
		beq		$t8, 0, Kiem_Tra_Hop_Le_2				# Kiem tra xem gap ky tu NULL chua
		beq		$t8, '\n', Kiem_Tra_Hop_Le_2			# Kiem tra xem co phai Enter khong
		beq		$t8, '+', push_s1		# Phep Cong
		beq		$t8, '-', push_s1		# Phep Tru
		beq		$t8, '*', push_s1		# Phep Nhan
		beq		$t8, '/', push_s1		# Phep Chia
		beq		$t8, '%', push_s1		# Chia Lay Du
		beq		$t8, '(', push_s1		# Ngoac Mo
		beq		$t8, ')', push_s1		# Ngoac Dong
		beq		$t8, ' ', continue_char	# Dau Cach
		
		slti	$t9, $t8, 48			# Kiem tra xem co phai so hay khong
		bne		$t9, $zero, Nhap_Lai	# Neu khong phai cac phep toan, dau cach, Kiem_Tra_Hop_Le_2 hay so thi bieu thuc ko hop le
		slti	$t9, $t8, 58			# 48 <= $t8 < 58
		bne		$t9, $zero, Interger	# Neu la so thi chuyen den Interger de phan tich
		
		j		Nhap_Lai				# Cac truong hop con lai deu ko hop le


	push_s1:	# Luu cac phep toan vao stack_1
		not		$t8, $t8
		addi	$t8, $t8, 1
		sw		$t8, 0($s0)					
		addi	$t7, $t7, 1
		addi	$s0, $s0, 4
		j		Read_Char				# Sau khi luu thi xet phan tu tiep

	continue_char:						# Ham nay se xet phan tu tiep theo
		addi	$t7, $t7, 1
		j		Read_Char			

	Nhap_Lai:							# Ham de nhap lai ham
		li		$v0, 55
		la		$a0, messenger_4
		syscall
		Reset:
			lw		$t8, 0($s0)
			beq		$t8, $zero, Nhap_bieu_thuc
			sw		$zero, 0($s0)
			addi	$s0, $s0, 4
			j		Reset
		
	Store_s1:							# Neu day la so co 1 chu so thi luu truc tiep vao stack_1
		sw		$s5, 0($s0)
		addi	$t7, $t7, 1
		addi	$s0, $s0, 4
		j		Read_Char

	Interger_2:							# Ham se xet so co 2 chu so se luu vao stack_1
		multu	$s5, $s2						# Lay so hang chuc
		mflo	$s5								
		addi	$t8, $t8, -48					# Tru ma ascii cua hang don vi de lay Integer tuong ung
		add		$s5, $s5, $t8					# Cong vao de lay dc so can tim
		sw		$s5, 0($s0)
		addi	$s0, $s0, 4
		addi	$t7, $t7, 2
		lb		$t8, 0($t7)
		beq		$t8, 0, Kiem_Tra_Hop_Le_2
		beq		$t8, $s4, Kiem_Tra_Hop_Le_2
		slti	$t9, $t8, 58
		beq		$t9, $zero, Nhap_Lai
		slti	$t9, $t8, 48
		beq		$t9, $zero, Nhap_Lai
		j		Read_Char
	
	Interger:									# Ham xet so co 1 chu so
		addi	$s5, $t8, -48					# T? mã ascii ta tru cho 48 se ra so Integer tuong ung
		lb		$t8, 1($t7)						# Xet ky tu tiep theo xem co phai la so 2 chu so hay khong
		slti	$t9, $t8, 48
		bne		$t9, $zero, Store_s1			# Neu la so co 1 chu so thi t se luu luon vao Stack_1
		slti	$t9, $t8, 58
		bne		$t9, $zero, Interger_2			# Neu la so co 2 chu so thi t se sang de chuyen thanh so 2 chu so
		beq		$t8, 0, Kiem_Tra_Hop_Le_2		# Kiem tra xem co phai ky tu 'NULL' hay khong
		beq		$t8, $s4, Kiem_Tra_Hop_Le_2		# Kiem tra xem co phai ky tu '\n' hay khong

# Tat ca da duoc luu trong Stack_1
# Giai phong thanh ghi $t7, $t8, $t9, $s2, $s3, $s4, $s5, $s6, $s7
# $s0 la stack_1 luu cac toan tu, toan hang cua bieu thuc
Kiem_Tra_Hop_Le_2:	# Kiem tra xem Bieu Thuc Nhap co Dung hay Khong
	addi	$s0, $gp, 0

	lw		$t8, 0($s0)					# Xet Phan tu dau tien Neu la cac toan tu thi BT ko hop le
	beq		$t8, $t2, Nhap_Lai		# Phep Nhan
	beq		$t8, $t3, Nhap_Lai		# Phep Chia
	beq		$t8, $t4, Nhap_Lai		# Chia Lay Du
	beq		$t8, $t6, Nhap_Lai		# Ngoac Dong
	
	Loop:
		lw		$t8, 0($s0)
		beq		$t8, $t0, Cong			# Phep Cong
		beq		$t8, $t1, Cong			# Phep Cong
		beq		$t8, $t2, Cong			# Phep Nhan
		beq		$t8, $t3, Cong			# Phep Chia
		beq		$t8, $t4, Cong			# Chia Lay Du
		beq		$t8, $t5, Mo_Ngoac		# Mo Ngoac
		beq		$t8, $t6, Dong_Ngoac	# Dong Ngoac
		beq		$t8, 0, Done			# NULL
		j		Number
		
		Cong:
			lw		$t8, 4($s0)
			beq		$t8, $t0, Nhap_Lai			# Phep Cong
			beq		$t8, $t1, Nhap_Lai			# Phep Tru
			beq		$t8, $t2, Nhap_Lai			# Nhan
			beq			$t8, $t3, Nhap_Lai			# Chia
			beq		$t8, $t4, Nhap_Lai			# Chia Lay Du
			beq		$t8, $t5, Nhap_Lai			# Dong Ngoac
			beq		$t8, 0  , Nhap_Lai			# NULL
			addi	$s0, $s0, 4
			j		Loop

		Mo_Ngoac:
			lw		$t8, 4($s0)
			beq		$t8, $t2, Nhap_Lai			# Nhan
			beq		$t8, $t3, Nhap_Lai			# Chia
			beq		$t8, $t4, Nhap_Lai			# Chia Lay Du
			beq		$t8, 0  , Nhap_Lai			# NULL		
			addi	$s0, $s0, 4
			addi	$fp, $fp, 1
			j		Loop
	
		Dong_Ngoac:
			lw		$t8, 4($s0)
			beq		$t8, $t5, Nhap_Lai			# Dong Ngoac
			slti	$t9, $t8, 0
			beq		$t9, 0, Nhap_Lai
			addi	$fp, $fp, -1
			beq		$t8, 0, Done
			addi	$s0, $s0, 4
			j		Loop
	
		Number:
			lw		$t8, 4($s0)
			beq		$t8, $t4, Nhap_Lai			# Mo Ngoac
			beq		$t8, 0  , Done
			j		Loop

Done:
	bne		$fp, 0, Nhap_Lai

# Tat ca da duoc luu trong Stack_1
# Giai phong thanh ghi $t7, $t8, $t9, $s2, $s3, $s4, $s5, $s6, $s7, $fp
# $s0 la stack_1 luu cac toan tu, toan hang cua bieu thuc

# Chuyen sang hau to
	addi	$s0, $gp, 0				# Stack 1 Chua Cac Toan Tu, Toan Hang Sau khi da check
	addi	$s1, $sp, 4				# Stack 2 Chua Cac Toan Tu De Duyet
	addi	$fp, $sp, -4			# Stack 3 Chua PostFix
Convert_To_Hau_To:
	lw		$t7, 0($s0)
	beq		$t7, -45, Check_sub		# Check phep Tru
	beq		$t7, -44, Check_Add		# Check phep Cong
	Loop_2:
		lw		$t7, 0($s0)
		beq		$t7, $t5, Ngoac_Mo	# Check Ngoac Mo
		beq		$t7, $t1, Dau_Cong
		beq		$t7, $t2, Dau_Tru
		beq		$t7, $t3, Dau_Nhan
		beq		$t7, $t4, Dau_Chia
		beq		$t7, $t5, Dau_Chia_Du
		beq		$t7, $
		
	Check_Sub:
		sw		$zero, 0($fp)
		addi	$fp, $fp, -4
		addi	$s0, $s0, 4
		j		Loop_2
	Check_Add:
		addi	$s0, $s0, 8
		j		Loop_2
	Ngoac_Mo:
		lw		$t8, 4($s0)
		beq		$t8, -45, Check_Sub
		beq		$t8, -44, Check_Add
		sw		$t5, 0($s1)				# Luu Ngoac Mo vao Stack 2
		addi	$s1, $s1, 4
		addi	$s0, $s0, 4
		j		Loop_2
		


Print_number:
	li	$v0, 1
	addi	$a0, $t8, 0
	syscall
	
Print_operater:
	li	$v0, 11
	abs		$a0, $t8
	syscall


	

	
	
