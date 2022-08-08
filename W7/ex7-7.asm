.data
	msg_0: .asciiz "Sinh va doan so ngau nhien trong khoang [1 : max_bound].\n"
	max_bound_str: .asciiz "max_bound: "
	guess_str: .asciiz "[+] Nhap du doan cua ban: "
	more_than_numb_str: .asciiz "[!] Lon hon mat roi ong chau oi!\n"
	less_than_numb_str: .asciiz "[!] Nho hon mat roi ong chau a!\n"
	equal_numb_str: .asciiz "[!] Ong chau doan dung roi!\nSo lan doan: "
.text
	ori $v0,$zero,4			#Print output1
	la $a0, msg_0
	syscall
	
	ori $v0,$zero,4			#Print output1
	la $a0, max_bound_str
	syscall
    
    	ori $v0,$zero,5			#Read input a from user
	syscall
	move $t0, $v0
	
    	move $a1, $v0  #Here you set $a1 to the max bound.
    	li $v0, 42  #generates the random number.
    	syscall
    	add $a0, $a0, 1  #Here you add the lowest bound
    	move $s0, $a0		#save generated number in $s0 register
    	
    	#li $v0, 1   #1 print generated number
    	#syscall
    	
    	ori $s1, $zero, 0
loop:
    	ori $v0,$zero,4			#Print
	la $a0, guess_str
	syscall
	
	ori $v0,$zero,5			#Read input a from user
	syscall
	move $t0, $v0
	
	add $s1, $s1, 1
	blt $s0, $t0, more_than
	bgt $s0, $t0, less_than
	    	
	ori $v0,$zero,4			#Print
	la $a0, equal_numb_str
	syscall
	
	li $v0, 1
	la $a0, ($s1)
	syscall
	
    	addi $v0,$zero,10
    	syscall
	
more_than:
    	ori $v0,$zero,4			#Print
	la $a0, more_than_numb_str
	syscall
	
	j loop
less_than:
    	ori $v0,$zero,4			#Print
	la $a0, less_than_numb_str
	syscall
	
	j loop
    	
    	
    	