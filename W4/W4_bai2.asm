.data
output0: .asciiz "Input integer: "
output1: .asciiz "\nInput value in binary: \t\t"
output2: .asciiz "\nResult after sll 4 bits: \t"
output3: .asciiz "\nResult after sllv 4 bits: \t"
output4: .asciiz "\nInput value in binary: \t\t"
output5: .asciiz "\nResult after srl 4 bits: \t"
output6: .asciiz "\nResult after srlv 4 bits: \t"
output7: .asciiz "\nInput value in binary: \t\t"
output8: .asciiz "\nResult after sra 4 bits: \t"
output9: .asciiz "\nResult after srav 4 bits: \t"
output10: .asciiz "\nInput value in binary: \t\t"
output11: .asciiz "\nResult after rol 4 bits: \t"
output12: .asciiz "\nResult after ror 4 bits: \t"

.text
main:
	# Nhap gia tri so nguyen vao may
	li $v0,4
	la $a0,output0
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0 # Luu gia tri cua so nguyen a vao thanh ghi $s0
	# In gia gia tri vua nhap duoi dang nhi phan
	li $v0,4
	la $a0,output1
	syscall
	
	li $v0,35
	move $a0,$s0
	syscall
	# Dich trai 4 bit so nguyen vua nhap roi in ra man hinh, dung ham sll
	li $v0,4
	la $a0,output2
	syscall
	
	sll $a0,$s0,4
	li $v0,35
	syscall
	# Dich trai 4 bit so nguyen vua nhap roi in ra man hinh, dung ham sllv
	li $v0,4
	la $a0,output3
	syscall
	
	li $t0,4
	sllv $a0,$s0,$t0
	li $v0,35
	syscall
	# In gia tri so nguyen ban dau duoi dang nhi phan
	li $v0,4
	la $a0,output4
	syscall
	
	li $v0,35
	move $a0,$s0
	syscall
	# Dich phai 4 vi tri sau do in duoi dang nhi phan ra man hinh, dung ham srl
	li $v0,4
	la $a0,output5
	syscall
	
	srl $a0,$s0,4
	li $v0,35
	syscall
	# Dich phai 4 vi tri sau do in duoi dang nhi phan ra man hinh, dung ham srlv
	li $v0,4
	la $a0,output6
	syscall
	
	srlv $a0,$s0,$v0
	li $v0,35
	syscall
	# In gia tri so nguyen ban duoi dang nhi phan dau ra man hinh
	li $v0,4
	la $a0,output7
	syscall
	
	li $v0,35
	move $a0,$s0
	syscall
	# Dich bit so hoc bang toan tu sra
	li $v0,4
	la $a0,output8
	syscall
	
	li $v0,35
	sra $a0,$s0,4
	syscall
	# Dich bit so hoc bang toan tu srav
	li $v0,4
	la $a0,output9
	syscall
	
	li $v0,35
	srav $a0,$s0,$v0
	syscall
	# In gia tri so nguyen ban duoi dang nhi phan dau ra man hinh
	li $v0,4
	la $a0,output10
	syscall
	
	li $v0,35
	move $a0,$s0
	syscall
	# Dich vong trai 4 bit
	li $v0,4
	la $a0,output11
	syscall
	
	li $v0,35
	rol $a0,$s0,4
	syscall
	# Dich vong trai 4 bit
	li $v0,4
	la $a0,output12
	syscall
	
	li $v0,35
	ror $a0,$s0,4
	syscall
	
	
	
	
