.data
result: .space 8        # Khai báo không gian cho k?t qu? (64 bit = 8 bytes)
message1: .asciiz "The multiplication of "
message2: .asciiz " and "
message3: .asciiz " is "
hexchar: .asciiz "0123456789abcdef"
.text
    li $v0, 4
    la $a0, message1
    syscall
    li $t0, 0x01234567      # Gán giá tr? cho $t0 (ví d?)
    li $t1, 0x01234567      # Gán giá tr? cho $t1 (ví d?)
    
    move $a0, $t0 
    li $v0, 34           
    syscall
    li $v0, 4
    la $a0, message2
    syscall
    move $a0, $t1
    li $v0, 34           
    syscall
    li $v0, 4
    la $a0, message3
    syscall
    mult $t0, $t1        # Phép nhân $t0 và $t1, k?t qu? l?u trong thanh ghi $hi và $lo

    # L?u tr? k?t qu? 64 bit vào vùng nh? result
    mfhi $t2             # Di chuy?n giá tr? c?a thanh ghi hi vào $t2
    mflo $t3             # Di chuy?n giá tr? c?a thanh ghi lo vào $t3
    la $s0,result
    sw $t2, ($s0)     # L?u 32 bit ??u tiên vào result
    sw $t3, 4($s0)    # L?u 32 bit còn l?i vào result + 4

    la $s1,hexchar
    lw $a0, 4($s0) 
    jal print   
    syscall
    lw $a0, ($s0) 
    jal print    
    syscall

    # K?t thúc ch??ng trình
    li $v0, 10           # Exit syscall
    syscall
print:
    move $t5,$a0
    li $t6,32
    li $t7,0xf0000000
    loop:
    	and $t8,$t7,$t5
    	sub $t6,$t6,4
    	srl $t7,$t7,4
    	srlv $t8,$t8,$t6
    	add $t8,$t8,$s1
    	lb $a0,($t8)
    	li $v0,11
    	syscall
    	bnez $t6,loop
    jr $ra
    	
