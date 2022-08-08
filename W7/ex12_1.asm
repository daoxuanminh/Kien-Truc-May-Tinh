
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main: 	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
		
	li $t3, 0x01
	loop: 
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	
	print: li, $v0,34
	syscall 
	sleep: li $a0, 200 # sleep 100ms
	li $v0, 32
	syscall
	jal PrintNewLine
	add $t3,$t3,$t3
	beq $t3,0x10,continue
	j loop
	continue: 
	li $t3, 0x01
	j loop
.include "utils.asm"
