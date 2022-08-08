.data
test: .asciiz "AcB"

.text 
	la $a0,test 	# Load địa chỉ của nhãn test vào thanh ghi $a0
	jal To_Lower 	# Chuyển vào hàm con To_Lower 
	sw $v0,($a0)	# load giá trị của $v0 vào địa chỉ của $a0
	la $a0,($a0)	# Lưu giá trị của $a0 thành địa chỉ của $a0
	jal PrintString # In chuỗi kết quả ra màn hình
	jal Exit	# Thoát chương trình
.include "BT5_3.asm"
