.data
output1: .asciiz "\nNhap so nguyen a: "
output2: .asciiz "\nNhap so nguyen b: "
output3: .asciiz "\nKet qua a XOR b lan 1: "
output4: .asciiz "\nKet qua XOR b lan 2: "

.text
.globl main
main:
	# In ra man hinh lable output1
	li $v0,4
	la $a0,output1
	syscall
	# Yeu cau nguoi dung nhap so nguyen a
	li $v0,5
	syscall
	move $s0,$v0
	# In ra man hinh so nguyen a dang hexa
	li $v0,34
	move $a0,$s0
	syscall
	# In ra man hinh lable output2
	li $v0,4
	la $a0,output2
	syscall
	# Yeu cau nguoi dung nhap so nguyen b
	li $v0,5
	syscall
	move $s1,$v0
	# In ra man hinh so nguyen b dang hexa
	li $v0,34
	move $a0,$s1
	syscall
	# In ra man hinh lable output3
	li $v0,4
	la $a0,output3
	syscall
	# Thuc hien phep toan a XOR b, roi in ra man hinh ket qua phep XOR dang hexa
	xor $s0,$s1,$s0
	li $v0,34
	move $a0,$s0
	syscall
	# In ra man hinh lable output4
	li $v0,4
	la $a0,output4
	syscall
	# Thuc hien phep XOR voi b them 1 lan nua, roi in ket qua o dang hex
	xor $a0,$s1,$s0
	li $v0,34
	syscall
	
	
