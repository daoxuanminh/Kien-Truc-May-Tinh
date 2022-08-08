.data
#cau lenh mips gom opcode va 3 toan hang. 
# lb $t1,$t2,$t3
register: .asciiz "$zero-$at-$v0-$v1-$a0-$a1-$a2-$a3-$t0-$t1-$t2-$t3-$t4-$t5-$t6-$t7-$t8-$t9-$s1-$s2-$s3-$s4-$s5-$s6-$s7-$k0-$k1-$gp-$sp-$fp-$ra-$0-$1-$2-$3-$4-$5-$6-$7-$8-$9-$10-$11-$12-$13-$14-$15-$16-$17-$18-$19-$20-$21-$22-$23-$24-$25-$26-$27-$28-$29-$30-$31-"
#ma opcode hop le:
opcode: .asciiz "addi-add-addiu-addu-and-andi-nop-nor-or-ori-sll-slt-slti-sub-subu-syscall-xor-xori-beq-bne-div-divu-j-jal-lui-mfhi-mflo-mul-la-lb-sb-"
#toan hang: 1 - rg, 2 - imd, 3 - Label, 0 - null
#toan hang tuong ung voi cac opcode tren:
operand: .asciiz "1124-1114-1124-1114-1114-1124-0001-1114-1114-1124-1124-1114-1124-1114-1114-0001-1114-1124-1133-1133-1104-1104-3003-3003-1204-1004-1004-1114-1305-1305-1305-"

msg1: .asciiz "\nNhap lenh can kiem tra: "
msg2: .asciiz "opcode: "
msg21: .asciiz ": hop le!"
msg22: .asciiz ": khong hop le hoac khong co trong thu vien!"
msg3: .asciiz "\nToan hang: "
msg4: .asciiz "\nCau lenh"
msg5: .asciiz "\nkiem tra them 1 lenh nua? 1(yes)|0(no): "
msg6: .asciiz "\nChu ky: "
input: .space 200 # chuoi dau vao
tmp: .space 20 #bien tmp luu thanh phan cat duoc
tmp2: .space 20 # luu khuon dang code
.text
main:
Input: # lay dau vao
	li	$v0, 4
	la	$a0, msg1
	syscall
	li	$v0, 8
	la	$a0, input 
	li	$a1, 200
	syscall
	#tach chu va so sanh
	la	$s0, input #dia chi input
	add	$s1, $zero, $zero # i -> dem tung ky tu trong tmp
readOpcode: 
	add	$a0, $s0, $zero # truyen tham so vao cutComponent
	add	$a1, $s1, $zero #
	la	$a2, tmp
	jal	cutComponent
	add	$s1, $v0, $zero #
	add	$s7, $v1, $zero #so ky tu co trong opcode
checkOpcode:	
	la	$a0, tmp
	add	$a1, $s7, $zero
	la	$a2, opcode
	jal 	compareOpcode
	add	$s2, $v0, $zero #check opcode
	add	$s3, $v1, $zero #count matching voi khuon dang toan hang
	li	$v0, 4
	la	$a0, msg2
	syscall
	li	$v0, 4
	la	$a0, tmp
	syscall
	bne	$s2, $zero, validOpcode # neu opcode hop le -> valid
invalidOpcode: #opcode ko hop le
	li	$v0, 4
	la	$a0, msg22
	syscall
	j	exit
validOpcode:	
	li	$v0, 4
	la	$a0, msg21
	syscall
	#-------lay khuon dang tuong ung voi opcode
	la	$a0, operand
	add	$a1, $s3, $zero #truyen vao count
	jal	getOperand #tra ve tmp2 - khuon dang
	
	li	$v0, 4
	la	$a0, tmp2
	syscall
	
	la		$s4, tmp2	#khuon dang
	add		$s5, $zero, $zero #toan hang 1 2 3  - dem
	add		$t9, $zero, 48 #0
	addi	$t8, $zero, 49 #1
	addi	$t7, $zero, 50 #2
	addi	$t6, $zero, 51 #3
	
Cmp: # kiem tra dang cua tung toan hang va check
	slti	$t0, $s5, 3 # xem da duyet qua het 3 toan hang chua
	beq	$t0, $zero, end
	#-----------lay toan hang 1
	add	$a0, $s0, $zero
	add	$a1, $s1, $zero
	la	$a2, tmp
	jal	cutComponent
	add	$s1, $v0, $zero # vi tri da cat den
	add	$s7, $v1, $zero #so ky tu co trong tmp
	#--so sanh toan hang 1
	add	$t0, $s5, $s4 # Dia chi cua tmp2[i]
	lb	$s6, 0($t0) #dang cua toan hang i
	beq	$s6, $t8, reg #1
	beq	$s6, $t7, number  #2
	beq	$s6, $t6, label #3
	beq	$s6, $t9, null #0
reg: #1
	la	$a0, tmp
	add	$a1, $s7, $zero
	la	$a2, register
	# khuon dang opcode trong thu vien giong voi khuon dang toan hang nen su dung lai ham compareOpcode
	#tra ve 0 -> error, 1 -> ok
	jal	compareOpcode
	j	checkValid
number: #2
	la	$a0, tmp
	add	$a1, $s7, $zero
	jal 	checkNumber
	j	checkValid
label:#3
	la	$a0, tmp
	add	$a1, $s7, $zero
	jal	checkLabel
	j	checkValid
null:#0
	j	print	
checkValid:
	add	$s2, $v0, $zero
	li	$v0, 4
	la	$a0, msg3
	syscall
	li	$v0, 4
	la	$a0, tmp
	syscall
	beq	$s2, $zero, error
	j	ok
updateCheck:	#buoc lap
	addi	$s5, $s5, 1
	j	Cmp

error:
	li	$v0, 4
	la	$a0, msg22
	syscall
	j	exit
ok:
	li	$v0, 4
	la	$a0, msg21
	syscall
	j	updateCheck
end:
	add	$a0, $s0, $zero
	add	$a1, $s1, $zero
	jal	cutComponent
	add	$s1, $v0, $zero #i hien tai
	add	$s7, $v1, $zero #so ky tu co trong tmp
print:	
	li	$v0, 4
	la	$a0, msg4
	syscall
	bne	$s7, $zero, error
	li	$v0, 4
	la	$a0, msg21
	syscall
	
printChuKy:	
	li	$v0, 4
	la	$a0, msg6
	syscall
	li $v0,4
	la $a0,tmp2
	addi $a0,$a0,3
	syscall

exit:
	repaetMain:
		li	$v0, 4
		la	$a0, msg5
		syscall
		li	$v0, 8
		la	$a0, input
		li	$a1, 100
		syscall
		checkRepeat:
			addi	$t2, $zero, 48
			addi	$t3, $zero, 49
			add	$t0, $a0, $zero #ki tu dau tien
			lb	$t0, 0($t0)
			beq	$t0, $t2, out# =0
			beq	$t0, $t3, main
			j	repaetMain 
	out:
		li $v0, 10 #exit
		syscall
#--------------------------------------------------------	
# tach toan hang,, opcode tu chuoi dau vao
# a0 address input, a1 i-> dem tmp. a2 address tmp
# v0 i = i+ strlen(tmp), v1 strlen(tmp)
#--------------------------------------------------------
cutComponent:
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$s0, 12($sp) # space
	sw	$s2, 8($sp)	#j
	sw	$s3, 4($sp) #input[i]
	sw	$s4, 0($sp) #dau phay = 44
	
	addi	$s0, $zero, 32 #space
	addi	$t2, $zero, 10 #\n
	addi	$s4, $zero, 44 #dau phay = 44
	addi	$t3, $zero, 9 #\t
# add $t1,$t2,$t3
checkSpace: #bo qua , \t space
	add	$t0, $a0, $a1 #dia chi input[i]
	lb	$s3, 0($t0) #input[i]
	beq	$s3, $s0 cutSpace # space
 	beq	$s3, $t3 cutSpace # /t
	beq	$s3, $s4 cutSpace # ,
	j	cut
cutSpace:
	addi	$a1, $a1, 1
	j	checkSpace
cut:
	add	$s2, $zero, $zero #j = 0
loopCut:
	beq	$s3, $s0 endCut # space
	beq	$s3, $s4, endCut # ,
	beq	$s3, $zero, endCut #/0
	beq	$s3, $t2, endCut # /n
	beq	$s3, $t3 endCut #/t
	add	$t0, $a2, $s2 #dia chi tmp[j]
	sb	$s3, 0($t0) #luu tmp[j]
	addi	$a1, $a1, 1 # i++
	add	$t0, $a0, $a1 #dia chi input[i]
	lb	$s3, 0($t0) #input[i]
	
	addi	$s2, $s2, 1
	j	loopCut
endCut:
	add	$t0, $a2, $s2 #dia chi tmp[j]
	sb	$zero, 0($t0) #luu tmp[j] = '\0'
	add	$v0, $a1, $zero
	add	$v1, $s2, $zero
	lw	$ra, 16($sp)
	lw	$s0, 12($sp)
	lw	$s2, 8($sp)
	lw	$s3, 4($sp)
	lw	$s4, 0($sp)
	addi	$sp, $sp, 20
	jr	$ra
	
#--------------------------------------------------------
# so sanh toan hang, opcode voi toan hang, opcode chuan
# a0 address tmp, a1 strlen(tmp), a2 adress cua chuoi opcode, register chu?n
# v0 0|1, v1 count vi tri cua opcode
#--------------------------------------------------------
compareOpcode:
	addi	$sp, $sp, -24
	sw	$ra, 20($sp)
	sw	$s1, 16($sp) #i -> opcode
	sw	$s2, 12($sp) #j -> tmp
	sw	$s3, 8($sp) #tmp[j]
	sw	$s4, 4($sp)	#luu opcode[i]
	sw	$s5, 0($sp) # - 45
	
	beq	$a1, $zero, endCmp

	add	$s1, $zero, $zero
	add	$s2, $zero, $zero
	addi	$s5, $zero, 45
	addi	$v0, $zero, 1
	addi	$v1, $zero, 1
loopCmp:
	add	$t0, $a2, $s1 #dia chi opcode[i]
	lb	$s4, 0($t0) #luu opcode[i]
	beq	$s4, $s5, checkCmp
	beq	$s4, $zero, endCmp # Nhay cuoi cua thu vien opcode
	add	$t0, $a0, $s2 #dia chi tmp[j]
	lb	$s3, 0($t0) #luu tmp[j]
	bne	$s3, $s4, falseCmp
	
	addi	$s1, $s1, 1
	addi	$s2, $s2, 1
	j	loopCmp
checkCmp:
	bne	$a1, $s2, falseCmp
trueCmp:
	addi	$v0, $zero, 1
	j	endF

falseCmp:
	addi	$v0, $zero, 0
	addi	$s2, $zero, 0
	loopXspace: # tim dau -
		beq	$s4, $s5, Xspace
		addi	$s1, $s1, 1
		add	$t0, $a2, $s1 #dia chi opcode[i]
		lb	$s4, 0($t0) #luu opcode[i]
		j	loopXspace
		Xspace:
			add	$v1, $v1, 1
			addi	$s1, $s1, 1
			j	loopCmp
endCmp:
	addi	$v0, $zero, 0
endF:	
	addi	$v1, $v1, -1 # dem vi tri cua opcode tu 0
	lw	$ra, 20($sp)
	lw	$s1, 16($sp)
	lw	$s2, 12($sp)
	lw	$s3, 8($sp) 
	lw	$s4, 4($sp)	
	lw	$s5, 0($sp)
	addi	$sp, $sp, 24
	jr	$ra
#--------------------------------------------------------
# lay khuon dang toan hang ung voi opcode
# a0 address chuoi operand - vi tri tuong ung voi opcode, a1 count
# tra ve chuoi opcode tuong ung � tmp2 =
#--------------------------------------------------------
getOperand: 
	addi	$sp, $sp, -20
	sw	$s0, 16($sp) #i
	sw	$s1, 12($sp) #op[i]
	sw	$s2, 8($sp) # 45
	sw	$s3, 4($sp) # address tmp2
	sw	$s4, 0($sp)	# j

	addi	$t0, $zero, 5 #moi khuon dang chiem 4 byte
	mul	$s0, $a1, $t0 # i hien tai
	addi	$s2, $zero, 45 # -
	la	$s3, tmp2 
	add	$s4, $zero, $zero #j
loopGet:	
	add	$t0, $a0, $s0 #dia chi op
	lb	$s1, 0($t0)
	beq	$s1, $s2, endGet #gap - -> out
	add	$t0, $s3, $s4 #dia chi tmp2[i]
	sb	$s1, 0($t0)
	
	addi	$s0, $s0, 1
	addi	$s4, $s4, 1
	j	loopGet
endGet:
	add	$t0, $s3, $s4 #dia chi tmp[i]
	sb	$zero, 0($t0)
	lw	$s0, 16($sp) #i
	lw	$s1, 12($sp) #op[i]
	lw	$s2, 8($sp) #
	lw	$s3, 4($sp) #
	lw	$s4, 0($sp)	#
	addi	$sp, $sp, 20
	jr $ra
#--------------------------------------------------------
# kiem tra chuoi tmp co la so hay ko -> 0 -> sai, 1-> dung
# a0 address tmp, a1 strlen(tmp)
# v0 0|1
#--------------------------------------------------------
checkNumber:
	add	$sp, $sp, -24
	sw	$ra, 20($sp)
	sw	$s4, 16($sp) #+
	sw	$s3, 12($sp) #-
	sw	$s0, 8($sp) #i
	sw	$s1, 4($sp)
	sw	$s2, 0($sp) #1
	add	$v0, $zero, 0
	add	$s0, $zero, $zero #dem i
	
	beq	$a1, $zero, endCheckN # if strlen(tmp) = 0
checkFirstN:
	addi 	$s3, $zero, 45 # -
	addi	$s4, $zero, 43 # +
	addi	$s2, $zero, 1
	add	$t0, $a0, $s0 #toanhang[i]
	lb	$s1, 0($t0)
	#check - +  -> 123
checkMinus: 
	bne	$s1, $s3, checkPlus
	beq	$a1, $s2, endCheckN # check den cuoi tmp chua
	j	update
checkPlus:
	bne	$s1, $s4, _123
	beq	$a1, $s2, endCheckN
	j	update
#lb	$t2, 0($s1)
	
checkI:
	slt	$t0, $s0, $a1 # xem da duyet het phan tu chua
	beq	$t0, $zero, trueN
	add	$t0, $a0, $s0 #toanhang[i]
	lb	$s1, 0($t0)
_123: #48 -> 57
	slti 	$t0, $s1, 48
	bne	$t0, $zero, endCheckN
	slti	$t0, $s1, 58
	beq	$t0, $zero, endCheckN
update:
	addi	$s0, $s0, 1
	j	checkI
trueN:
	addi	$v0, $v0, 1
endCheckN:
	lw	$ra, 20($sp)
	lw	$s4, 16($sp) #+
	lw	$s3, 12($sp) #-
	lw	$s0, 8($sp)
	lw	$s1, 4($sp)
	lw	$s2, 0($sp)
	add	$sp, $sp, 24
	jr	$ra
#--------------------------------------------------------
# kiem tra chuoi tmp co la Label hay ko, ki tu dau tien: _ | A -> _ | A | 1 
# a0 -> address tmp, a1 strlen(tmp)
# v0 0|1 
#--------------------------------------------------------
checkLabel:
	add	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$s1, 4($sp) # tmp[i]
	sw	$s0, 0($sp) #i
	add	$v0, $zero, 0
	add	$s0, $zero, $zero #dem i
	
	beq	$a1, $zero, endCheckL

checkFirstChar:
	add	$t0, $a0, $s0 #toanhang[i]
	lb	$s1, 0($t0)
	j	ABC	

checkIL:
	slt	$t0, $s0, $a1
	beq	$t0, $zero, trueL
	add	$t0, $a0, $s0 #toanhang[i]
	lb	$s1, 0($t0)
_123L: #48 -> 57
	slti	$t0, $s1, 48
	bne	$t0, $zero, endCheckL
	slti	$t0, $s1, 58
	beq	$t0, $zero, ABC
	addi	$s0, $s0, 1
	j	checkIL
ABC: #65 -> 90
	slti	$t0, $s1, 65
	bne	$t0, $zero, endCheckL
	slti	$t0, $s1, 91
	beq	$t0, $zero, _
	addi	$s0, $s0, 1
	j	checkIL
_:
	add	$t0, $zero, 95
	bne	$s1, $t0, abc
	addi	$s0, $s0, 1
	j	checkIL
abc: #97  -> 122
	slti	$t0, $s1, 97
	bne	$t0, $zero, endCheckL
	slti	$t0, $s1, 123
	beq	$t0, $zero, endCheckL
	addi	$s0, $s0, 1
	j	checkIL
trueL:
	addi	$v0, $v0, 1
endCheckL:
	sw	$ra, 8($sp)
	lw	$s1, 4($sp)
	lw	$s0, 0($sp)
	add	$sp, $sp, 12
	jr	$ra
	


