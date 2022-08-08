.data
	Nhap: .asciiz "Nhap vao mot dong lenh hop ngu: "
	continueMessage: .asciiz "Ban muon tiep tuc chuong trinh?(0.Yes/1.No)"
	errMessage: .asciiz "Lenh hop ngu khong hop le. Loi cu phap!\n"
	NF: .asciiz "Khong tim duoc khuon dang lenh nay!\n"
	endMess: .asciiz "\nHoan thanh! Lenh vua nhap vao phu hop voi cu phap!\n"
	hopLe1: .asciiz "Opcode: "
	hopLe11: .asciiz "Toan hang: "
	hopLe2: .asciiz " hop le.\n"
	chuKyMess: .asciiz "So chu ky cua lenh la: "
	
	dauVao: .space 100
	opCode: .space 30
	rg1: .space 30
	rg2: .space 30
	rg3: .space 30
	imed: .space 30
	lable: .space 40
	khuonDang: .space 5
	# quy luat cua library: opcode co do dai = 5 byte
	# moi lenh co 3 toan hang va chi co 4 loai la: thanh ghi = 1, hang so nguyen =2, dinh danh = 3 hoac khong co = 0.
	library: .asciiz "or***1114;add**1114;xor**1114;jr***1003;jal**3003;sub**1114;and**1114;beq**1133;bne**1133;j****3003;nop**0001;sw***1305,lw***1305"
	charGroup: .asciiz "qwertyuiopasdfghjklmnbvcxzQWERTYUIOPASDFGHJKLZXCVBNM_"
	numberGroup: .asciiz "0123456789 "
	tokenRegisters: .asciiz "$zero $at   $v0   $v1   $a0   $a1   $a2   $a3   $t0   $t1   $t2   $t3   $t4   $t5   $t6   $t7   $s0   $s1   $s2   $s3   $s4   $s5   $s6   $s7   $t8   $t9   $k0   $k1   $gp   $sp   $fp   $ra   $0    $1    $2    $3    $4    $5    $7    $8    $9    $10   $11   $12   $13   $14   $15   $16   $17   $18   $19   $20   $21   $22   $21   $22   $23   $24   $25   $26   $27   $28   $29   $30   $31   "
.text
# Lenh co do dai toi da la 100
# Lenh nhap vao duoc luu o trong dia chi cua nhan 'daoVao'
# Thanh ghi $s0 luu dia chi cua xau dau vao(dia chi co so)
main:
	jal Input
	jal tachOpcode
	# So sanh opCode co trong thu vien khong de xem dinh dang cua lenh
	jal checkOpCode # $v1 = 1 la co opcode trong thu vien, =0 la ko co
	move $a0,$v1
	jal thongBaoSauKhiCheckOpCode
	jal docKhuonDangLenh # Khuon dang lenh duoc luu o lable khuonDang
	
	
	
	jal tachThanhGhi1
	jal tachThanhGhi2
	jal tachThanhGhi3
	jal Check1
	Luot1:
	la $t6,khuonDang
	la $a0,rg1
	lb $t7,0($t6)
	beq $t7,48,checkRong1
	beq $t7,49,checkDungSaiRg1
	beq $t7,50,checkDungSaiImd1
	beq $t7,51,checkDungSaiLable1

	Luot2:
	la $a0,rg2
	lb $t7,1($t6)
	beq $t7,48,checkRong2
	beq $t7,49,checkDungSaiRg2
	beq $t7,50,checkDungSaiImd2
	beq $t7,51,checkDungSaiLable2

	Luot3:
	la $a0,rg3
	lb $t7,2($t6)
	beq $t7,48,checkRong3
	beq $t7,49,checkDungSaiRg3
	beq $t7,50,checkDungSaiImd3
	beq $t7,51,checkDungSaiLable3
	
	checkRong1:
	jal checkRong
	jal Luot2
	checkRong2:
	jal checkRong
	jal Luot3
	checkRong3:
	jal checkRong
	jal Exit
	
	checkDungSaiRg1:
	jal checkDungSaiRg
	jal Luot2
	checkDungSaiRg2:
	jal checkDungSaiRg
	jal Luot3
	checkDungSaiRg3:
	jal checkDungSaiRg
	jal Exit
	
	checkDungSaiImd1:
	jal checkDungSaiImd
	jal Luot2
	checkDungSaiImd2:
	jal checkDungSaiImd
	jal Luot3
	checkDungSaiImd3:
	jal checkDungSaiImd
	jal Exit
	
	checkDungSaiImd1:
	jal checkDungSaiImd
	jal Luot2
	checkDungSaiImd2:
	jal checkDungSaiImd
	jal Luot3
	checkDungSaiImd3:
	jal checkDungSaiImd
	jal Exit
	
	Exit:
	li $v0,10
	syscall

InHopLe:
	li $v0,4
	la $a0,hopLe2
	syscall
	jr $ra

#-------------------------------

checkRong:
	lb $t0,0($a0)
	li $v0,0
	beq $t0,0,rong
	jr $ra
	rong:
		li $v0,1
		beq $v0,1,InHopLe
		jr $ra
endCheckRong:
#----------------------------------
checkDungSaiRg:
	# $a0 la thanh ghi dau vao
	addi $v0,$0,0	# v0 la de ghi so phan tu
	move $s0,$a0 
	strlen:
		lb  $v1,0($a0)
		beq $v1,0,endStrLen
		addi $v0,$v0,1
		addi $a0,$a0,1
	endStrLen:
	li $v1,0 # reset
	li $t3,0 # bien dem
	move $a0,$s0
	la $a1,tokenRegisters
	la $a2,tokenRegisters
	
	
endCheckDungSaiRg:

#----------------------------------
checkDungSaiLable:
	li $v0,0 # reset
	lb $t0,0($a0)
	addi $t0,$t0,-48
	bge  $t0,0,saiNhan
	dungNhan:
		addi $v0,$v0,1
		jr $ra
	saiNhan:
		bgt  $t0,9,dungNhan
		beq $v0,1,InHopLe
		jr $ra
endCheckDungSaiLable:

#----------------------------------
checkDungSaiImd:
	li $v0,0 # reset
	li $t0,10
	li $t1,0
	ForCheck1:
		la $t4,numberGroup
		start:
		add $t2,$a0,$t1
		lb $t3,0($t2)
		beq $t3,0,Dung
		ForCheck2:
			lb $t5,0($t4)
			beq $t5,$t3,done
			beq $t5,0x20,Sai
			addi $t4,$t4,1
			j ForCheck2
		EndForCheck2:
		done:
		addi $t1,$t1,1
		j ForCheck1
	EndForCheck1:
	Dung:
		li $v0,1
		jr $ra
	Sai:
		jr $ra
endCheckDungSaiImd:

#----------------------------------



docKhuonDangLenh:
	addi $a2,$a2,5
	la $a3,khuonDang
	add $t0,$0,$0
	for:
		beq $t0,4,endFor
		lb $t1,0($a2)
		sb $t1,0($a3)
		addi $a2,$a2,1
		addi $a3,$a3,1
		addi $t0,$t0,1 # i++
		j for
	endFor:
	jr $ra
	# 4 thanh ghi tu $t0 den $t3 se chua khuon dang lenh
endDocKhuonDangLenh:
	

thongBaoSauKhiCheckOpCode:
	beq $a0,1,coOpCode
	beq $a0,0,khongCoOpCode
	coOpCode:
		li $v0,4
		la $a0,hopLe1
		syscall
		li $v0,4
		la $a0,opCode
		syscall
		li $v0,4
		la $a0,hopLe2
		syscall
		jr $ra
	khongCoOpCode:
		li $v0,4
		la $a0,NF
		syscall
		li $v0,10
		syscall
endThongBaoSauKhiCheckOpCode:
	



checkOpCode:
	li $t3,0 # bien dem
	la $a0,opCode
	la $a1,library
	la $a2,library
	loopCheckOpCode:
		beq $t3,$s1,CheckSao
		lb $t0,0($a0)
		lb $t1,0($a1)
		bne $t0,$t1,nextStep
		addi $a0,$a0,1
		addi $a1,$a1,1
		addi $t3,$t3,1 # i++
		j loopCheckOpCode
	endLoopCheckOpCode:	
	nextStep:
		li $t3,0
		la $a0,opCode
		lb $t4,0($a2)
		addi $a2,$a2,10
		beq $t4,0,end
		move $a1,$a2
		j loopCheckOpCode
	CheckSao:
		lb $t4,1($a1)
		beq $t4,0x2a,addThem
		j nextStep
		addThem:
		li $v1,1
	end:
	jr $ra
endCheckOpCode:
	
	

Input:
	li $v0, 54
	la $a0, Nhap
	la $a1,	dauVao
	li $a2,100
	syscall
	add $s0,$a1,$zero
tachOpcode:
	la $a0,dauVao 	# $a0 se duyet qua tung phan tu trong xau dau vao 
	la $a1,opCode
	li $t0,0		# index i
	loopTachOpCode:
		lb 	$t1,0($a0)
		beq	$t1,0x20,endTachOpCode
		beq $t1,10,ketThucTach
		sb 	$t1,0($a1)
		addi $t0,$t0,1
		addi $a0,$a0,1
		addi $a1,$a1,1
		j loopTachOpCode
	endTachOpCode:
	move $s1,$t0 # Thang ghi $s1 luu cac gia tri tam thoi cua vi tri dang duoc cat den
	jr $ra

tachThanhGhi1:
	la $a0,dauVao 	# $a0 se duyet qua tung phan tu trong xau dau vao 
	la $a1,rg1
	move $t0,$s1
	addi $t0,$t0,1
	add $a0,$a0,$t0
	loopTachThanhGhi1:
		lb 	$t1,0($a0)
		beq	$t1,44,endTachThanhGhi1
		beq $t1,10,ketThucTach
		sb 	$t1,0($a1)
		addi $t0,$t0,1
		addi $a0,$a0,1
		addi $a1,$a1,1
		j loopTachThanhGhi1
	endTachThanhGhi1:
	move $s1,$t0
	jr $ra
	
tachThanhGhi2:
	la $a0,dauVao 	# $a0 se duyet qua tung phan tu trong xau dau vao 
	la $a1,rg2
	move $t0,$s1
	addi $t0,$t0,1
	add $a0,$a0,$t0
	loopTachThanhGhi2:
		lb 	$t1,0($a0)
		beq	$t1,44,endTachThanhGhi2
		beq $t1,0x0a,ketThucTach
		sb 	$t1,0($a1)
		addi $t0,$t0,1
		addi $a0,$a0,1
		addi $a1,$a1,1
		j loopTachThanhGhi2
	endTachThanhGhi2:
	move $s1,$t0
	jr $ra
	
tachThanhGhi3:
	la $a0,dauVao 	# $a0 se duyet qua tung phan tu trong xau dau vao 
	la $a1,rg3
	move $t0,$s1
	addi $t0,$t0,1
	add $a0,$a0,$t0
	loopTachThanhGhi3:
		lb 	$t1,0($a0)
		beq	$t1,44,endTachThanhGhi3
		beq $t1,0x0a,ketThucTach
		sb 	$t1,0($a1)
		addi $t0,$t0,1
		addi $a0,$a0,1
		addi $a1,$a1,1
		j loopTachThanhGhi3
	endTachThanhGhi3:
	move $s1,$t0
	jr $ra
ketThucTach:
	move $s1,$t0
	addi $s1,$s1,-1
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
