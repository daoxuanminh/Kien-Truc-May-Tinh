# Note 
	# Ham nay co 2 tham so truyen vao la $a0,$a1 voi a1 la xau co san va a0 la xau can duoc coppy vao
.data
x: .asciiz "abcde"
y: .asciiz "adcaa"

.text
main:
	la	$s6,x	# Dia chi co dinh cua xau x
	la	$s7,y	# Dia chi co dinh cua xau y
	
	la 	$a0,x	# truyen tham so
	jal	strlen	# Ket qua duoc ghi vao thanh ghi $a0
	la 	$a0,y	# truyen tham so
	jal	strlen	# Ket qua duoc ghi vao thanh ghi $a0
	add 	$s0,$zero,0	# Bien danh chi so index cua loop1
	loop1:
		bge	$s0,$a0,end_of_loop1	# Neu s0 > 13 thi nhay den ket thuc
		add 	$t1,$s0,$s6		# t1 luu dia chi cua x[i]
		lb	$t0,0($t1)		# t0 luu gia tri cua x[i]
		add 	$s1,$zero,0	# s1 dung de danh chi so index cho y[j]
		loop2:
			
			
			
			end_of_loop2:
		add	$s0,$s0,1		# tang chi so index
		j	loop1
		end_of_loop1:
	#jal	PrintInt
	jal	Exit
	
.include "utils.asm"	
		 
		
		
		
