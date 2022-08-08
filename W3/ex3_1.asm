.text
	addi $s0,$zero,0x2110003d
	add $s0,$zero,$s0luilui
	#vì khi cộng 32bit thì máy sẽ pahri thực hiện 2 bước. 
	#bước 1 dùng toán tử lui nạp 16 bit cao vào thanh ghi $at
	#buoc 2 dùng toán tử ori nạo 16 bit thấp vào thanh ghi $at
	# roi sau đó mới cộng 