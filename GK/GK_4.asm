.data
mss_input1: .asciiz "Nhap so phan tu cua mang: "
mss_input2: .asciiz "Nhap gia tri: "
mss_input4: .asciiz "Nhap gia tri m: "
mss_input5: .asciiz "Nhap gia tri M: "
mss_output1: .asciiz "Max: "
mss_output2: .asciiz "So phan tu nam trong doan (n;M): "
mss_check1: .asciiz "ERROR!!!\n"
mss_check2: .asciiz "M < m"
mss_check3: .asciiz "Khong phai la so nguyen duong!\n"
.text
#----------------------------------------------------------
# @note Ham main se co cac buoc thuc hien nhu sau
# B1: Nhap so phan tu cua mang 
# B2: Check xem nguoi dung co nhap dung so nguyen hay khong! Neu khong Exit
# B3: Vao vong lap de nhap phan tu cho mang so nguyen(Co check so nguyen neu khong dung Exit)
# B4: In ra max cua mang
# B5: Nhap vao 2 so m,M (Check m<M thi thong bao loi roi Exit)
# B6: Duyet mang de tim so cac phan tu trong doan (m,M)
# B7: In so luong phan tu do ra man hinh
#-----------------------------------------------------------
main:
	# goi syscall 51 de nhap so phan tu cua mang
	la 	$a0,mss_input1
	jal 	PromptInt	
	beq  	$a1,-1,Print_error	# check xem so nhap vao co phai la ky tu khong
	blez	$a0,Print_error		# Check so am
	move 	$s0,$a0				# $s0 luu so phan tu cua mang
	sll 	$a0,$s0,2			# Moi 1 so nguyen can 4 byte de luu tru $a1 = $s0*4
	# goi bo nho heap
	addi 	$v0,$0,9
	syscall
	move 	$s1,$v0			# $s1 luu dia chi co so cua mang
	addi 	$t0,$0,0		# $t0 bien dem trong vong loop
	addi 	$t1,$s1,0		# $t1 la tham tri den gia tri cua $s1
	# Vong lap de nhap so nguyen vao mang
	loop_input:
		beq		$t0,$s0,end_loop_input	# Neu index bang so phan tu thi dung loop
		la 		$a0,mss_input2		
		jal 	PromptInt	
		beq		$a0,0,Print_error	# check xem so nhap vao co phai la ky tu khong	
		sw		$a0,0($t1)		# Luu gia tri vua nhap vao bo nho dong heap
		addi	$t1,$t1,4		# lay them vi tri cho phan tu tiep theo
		addi 	$t0,$t0,1		# Tang index i lên 1
		jal 	loop_input
	end_loop_input: 
	move 	$a0,$s1			# $a0 la tham so chuyen vao chua dia chi co so mang
	move 	$a1,$s0			# $a1 la tham so chuyen vao chua so luong phan tu cua mang
	jal 	find_max
	# In ra phan tu Max cua mang
	la 		$a0,mss_output1
	move 	$a1,$v0
	li		$v0,56
	syscall
	# Nhap m va M
	la 		$a0,mss_input4
	jal 	PromptInt
	beq		$a0,-1,Print_error	# check xem so nhap vao co phai la ky tu khong
	move 	$s2,$a0		# $s2 = m
	la 		$a0,mss_input5	
	jal 	PromptInt	
	beq		$a0,-1,Print_error	# check xem so nhap vao co phai la ky tu khong
	move 	$s3,$a0		# $s3 = M
	# Kiem tra m voi M (m<M)!
	blt		$s3,$s2,eror	# Neu M<m thi nhay den thong bao loi va dung chuong trinh
	move	$a1,$s1		# $a0 luu dia chi co so mang
	addi 	$t0,$0,0	# $t0 la bien dem chi so i
	addi	$a0,$0,0	# Bien dem so phan tu nam trong khoang (m;M)
	loop_dem:
		beq		$t0,$s0,end_loop_dem	# Neu index bang so phan tu thi dung loop_dem
		lw		$t3,0($a1)		# Load phan tu ra thanh ghi $t3
		ble  	$t3,$s2,continue1	# Neu phan tu arr[i] <= m thì continue
		bge		$t3,$s3,continue1	# Neu phan tu arr[i] >= M thi continue
		addi 	$a0,$a0,1		# Neu trong [m;M] thi tang bien dem + 1
		continue1:
		addi 	$t0,$t0,1		# Tang bien dem index i
		addi	$a1,$a1,4		# Dia chi cua phan tu tiep theo trong mang
		j 	loop_dem
	end_loop_dem:
	# In ra ket qua so phan tu nam trong khoang (m;M)
	move 	$a1,$a0
	la 		$a0,mss_output2
	li		$v0,56
	syscall
	jal		Exit
	# Thong bao loi neu m < M
	eror:
		li	$v0,59
		la	$a0,mss_check1
		la	$a1,mss_check2
		syscall
		jal Exit
end_main:
#----------------------------------------------------------
# @brief Tim gia tri lon nhat cua mang
# @param[in] $t0 la bien dem i
# @param[in] $t1 la so lon nhat tam thoi khi duyet mang
# @param[in] $t3 se chi den tung gia tri cua cac phan tu trong mang
# @param[in] $a0 la tham so chuyen vao chua dia chi co so mang
# @param[in] $a1 la tham so chuyen vao chua so luong phan tu cua mang
# @return  $v0 tra ve gia tri lon nhat cua mang
#-----------------------------------------------------------
find_max:
	addi 	$t0,$0,0		# $t0 la bien dem index i
	lw		$t1,0($a0)		# $t1 lam max tam thoi
	loop: 
		beq		$t0,$a1,end_loop	# Neu index bang so phan tu thi dung loop
		lw		$t3,0($a0)		# Load phan tu ra thanh ghi $t3
		bge		$t1,$t3,Continue	# Neu max hien tai >= phan tu arr[i] thi continue
		move 	$t1,$t3			# Neu khong thi cap nhat max moi
		Continue:
		addi 	$t0,$t0,1		# Tang bien dem index i
		addi	$a0,$a0,4		# Dia chi cua phan tu tiep theo trong mang
		j 		loop
	end_loop:
	move 	$v0,$t1			# $v0 la thanh ghi dung de tra ve gia tri max cho ham main
	jr 		$ra
end_find_max:
#----------------------------------------------------------
# @brief Ham nay dung de goi ra hop thoai nhap so nguyen
# @param[in] $a0 chua dia chi cua xau ki tu trong phan .data
# @return  $a0 tra ve gia tri cua so nguyen vua nhap vao
#-----------------------------------------------------------
PromptInt:
	li 	$v0,51
	syscall
	jr 	$ra
#----------------------------------------------------------
# @brief Ham Kiem tra dau vao nhap tu ban phim co phai la so nguyen hay khong
#-----------------------------------------------------------
Print_error:
	li 	$v0,59
	la	$a0,mss_check1
	la	$a1,mss_check3
	syscall
	jal Exit
#----------------------------------------------------------
# @brief Ham thoat khoi chuong trinh
#-----------------------------------------------------------
Exit:
	li $v0,10
	syscall

