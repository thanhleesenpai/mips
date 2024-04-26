.data
result: .space 8        # Khai b�o kh�ng gian cho k?t qu? (64 bit = 8 bytes)
message1: .asciiz "The multiplication of "
message2: .asciiz " and "
message3: .asciiz " is "
hexchar: .asciiz "0123456789abcdef"
.text
    li $v0, 4
    la $a0, message1
    syscall
    li $t0, 0x01234567      # G�n gi� tr? cho $t0 (v� d?)
    li $t1, 0x01234567      # G�n gi� tr? cho $t1 (v� d?)
    
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
    mult $t0, $t1        # Ph�p nh�n $t0 v� $t1, k?t qu? l?u trong thanh ghi $hi v� $lo

    # L?u tr? k?t qu? 64 bit v�o v�ng nh? result
    mfhi $t2             # Di chuy?n gi� tr? c?a thanh ghi hi v�o $t2
    mflo $t3             # Di chuy?n gi� tr? c?a thanh ghi lo v�o $t3
    la $s0,result
    sw $t2, ($s0)     # L?u 32 bit ??u ti�n v�o result
    sw $t3, 4($s0)    # L?u 32 bit c�n l?i v�o result + 4

    la $s1,hexchar
    lw $a0, 4($s0) 
    jal print   
    syscall
    lw $a0, ($s0) 
    jal print    
    syscall

    # K?t th�c ch??ng tr�nh
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
    	
