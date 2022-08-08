.data
i: .word 3
j: .word 4
.text
start:
	lw	$s1,i
	lw 	$s2,j
	# $s1 = i
	# $s2 = j
	sge  	$t0,$s1,$s2
	bne 	$t0,$zero,else # Neu i>=j thi so sanh dung $t0=1 nhay den nhan else
	addi 	$t1,$t1,1
	addi 	$t3,$zero,1
	j 	endif
else:
	addi	$t2,$t2,-1
	add 	$t3,$t3,$t3
endif: