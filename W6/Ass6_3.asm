# ---Chu thich---
# Chi so index i duoc luu trong $s1
# Dia chi bat dau cua mang A duoc luu trong $s2
# n la so vong lap duoc luu trong $s3
# buoc nhay duoc luu trong $s4
# Tong duoc luu trong thanh ghi $s5
.data
arr: .word 1

.text
la $s2,arr
loop:
	add $s1,$s1,$s4
	add $t1,$s1,$s1
	add $t1,$s1,$s1
	add $t1,$t1,$s2
	lw  $t0,0($t1)
	add $s5,$s5,$t0
	bne $s1,$s3,loop
	
