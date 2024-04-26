.data
Message: .space 100 # Buffer 100 byte chua chuoi ki tu can 
.text
 	li $v0, 8
 	la $a0, Message
 	li $a1, 100
 	syscall 
 	move $t0, $a0   # Con tr? ??n ??u chu?i
    	li $t1, 0        # Bi?n ??m ?? dài chu?i
    
L:
    	lb $t2, 0($t0)    # ??c m?t ký t?
    	beqz $t2, E  # Ki?m tra ký t? k?t thúc
    	addi $t1, $t1, 1  # T?ng bi?n ??m
    	addi $t0, $t0, 1  # Di chuy?n con tr? t?i ký t? ti?p theo
    	j L     # L?p l?i vòng l?p
E:
	li $v0, 1
	addi $a0, $t1, -1   # Chu?n b? tham s? cho syscall in s? nguyên
    	syscall

	