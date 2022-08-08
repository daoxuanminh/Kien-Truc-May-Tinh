.data
i: .word 3
j: .word 4
.text
start:
	lw	$s1,i
	lw 	$s2,j
	# $s1 = i
	# $s2 = j
	slt 	$t0,$s2,$s1
	bne 	$t0,$zero,else
	addi 	$t1,$t1,1
	addi 	$t3,$zero,1
	j 	endif
else:
	addi	$t2,$t2,-1
	add 	$t3,$t3,$t3
endif: