PrintInt:
	li $v0,4
	syscall
	move $a0,$a1
	li $v0,1
	syscall
	# Khi gọi đến lệnh jal printf_newline thì thanh ghi $ra đang lưu lệnh trở về ở trương trình chính bị thay đổi
	# Nên ta lưu giá trị của thanh ghi $ra vào thanh ghi $t0 trước khi lệnh jal được thực hiện bằng lệnh: move $t0,$ra
	move $t0,$ra
	jal printf_newline
	# Cuối cùng khi ta muốn kết thúc chương trình con để về main thì ta chỉ cần gán thanh ghi $ra từ giá trị của thanh $t0 lúc nãy
	move $ra,$t0
	jr $ra