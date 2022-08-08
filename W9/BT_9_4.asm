.text
main: 
	li $a0, -45
	jal abs
	nop
	add $s0, $zero, $v0
	jal Exit
abs:
	sub $v0, $zero, $a0
	
	bltz $v0, done
	jr $ra
done:
	add $v0, $a0, $zero
	jr $ra
	
.include "utils.asm"