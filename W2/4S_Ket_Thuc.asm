# Bai tap 5
# Dao Xuan Minh
.data 

outputText_1: .asciiz "Chuong trinh da chay"
outputText_2: .asciiz "\nChuong trinh ket thuc"
.text 
main:
	# In ra bat dau
	li $v0,4
	la $a0,outputText_1
	syscall 
	
	# Nghi 4s
	li $v0,32
	li $a0,4000
	syscall 
	
	# In ra ket thuc
	li $v0,4
	la $a0,outputText_2
	syscall 
	
	# Exit 
	li $v0,10
	syscall 
	
	