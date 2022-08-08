.data
str: .asciiz "Nhap chuoi can dao: \n" 
msg: .asciiz
kq: .asciiz 
.text
.globl main
main: 


    li      $v0, 4          # print(intro)
    la      $a0, str
    syscall

    li      $v0, 8          # text = readString()
    la      $a0, msg
    li      $a1, 256        # (size of input buffer)
    
    
    syscall

    la      $t0, msg    # addr = text
    
    la $s2,kq
    move $t2,$s2
load:	lb $a0,0($t0)
		beq $a0,0,exit
		blt $a0,48,add_ki_tu
		bgt $a0,57,add_ki_tu
		jal load
exit:
add_ki_tu:	
			lb $a0,0($t2)
			addi $t2,$t2,1
			jr $ra
end:    li      $v0, 10         # exit cleanly
    	syscall