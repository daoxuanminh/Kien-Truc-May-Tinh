.data
output1: .asciiz "\nNhap so nguyen bat ki: "
output2: .asciiz "\nChi dung toan tu dich bit va cong: "
output3: .asciiz "\nKiem tra chinh xac: "
.text
	# In output 1 ra man hinh
	addi $v0,$0,4
	la $a0,output1
	syscall
	# Nguoi dung nhap so nguyen
	addi $v0,$0,5
	syscall
	add $s0,$0,$v0 # So nguyen nhap vao duoc luu o $s0
	# Cho so vua nhap nhan voi 10
	sll $s1,$s0,3
	add $s1,$s1,$s0
	add $s1,$s1,$s0 # Dich trai 3 bit va cong 2 lan
	# In ra man hinh output2 va ket qua
	addi $v0,$0,4
	la $a0,output2
	syscall
	
	addi $v0,$0,1
	add $a0,$s1,$0
	syscall
	# In ra man hinh ket qua kiem tra khi dung toan tu mult
	addi $v0,$0,4
	la $a0,output3
	syscall
	
	addi $t0,$0,10
	mult $s0,$t0
	mflo $a0
	
	addi $v0,$0,1
	syscall
	
	
	
	
	