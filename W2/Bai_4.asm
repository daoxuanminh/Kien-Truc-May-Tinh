# Random tu 1-100
.data 
Result: .asciiz  "Ket qua random: "
.text
main: 
	# In text
	li $v0,4
	la $a0,Result
	syscall
	
	# Random
	li $v0,42
	li $a1,100
	syscall
	
	# In ra so nguyen tu gia tri $a0
	li $v0,1
	syscall 
	
	# Exit 
	li $v0,10
	syscall 