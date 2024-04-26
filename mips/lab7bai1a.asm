.data
array:  .word  5, 7, 3, 11, 8, 2, 10, 6

.text
.globl main

main:
    # Kh?i t?o bi?n
    li $t0, 0        # L?u tr? s? l?n nh?t
    li $t1, 0        # L?u tr? ??a ch? c?a s? l?n nh?t
    li $t2, 0        # Bi?n ??m v�ng l?p
    li $t4, 0	     # L?u tr? s? l?n th? 2
    li $t5, 0	     # L?u tr? ??a ch? c?a s? l?n th? hai
    la $s0, array
    # V�ng l?p ?? so s�nh c�c ph?n t?
    Loop:
        beq $t2, 8, ExitLoop  # Tho�t kh?i v�ng l?p khi ?� so s�nh xong t?t c? c�c ph?n t?
	sll $t9,$t2,2	#$t9=4*$t0
        lw $t3, array($t9)  # L?y gi� tr? c?a ph?n t? th? $t2
        bgt $t3, $t0, UpdateMax  # N?u gi� tr? n�y l?n h?n gi� tr? hi?n t?i c?a s? l?n nh?t, c?p nh?t l?i
	bgt $t3, $t4, UpdateSecondMax # N?u gi� tr? n�y l?n h?n gi� tr? hi?n t?i c?a s? l?n th? hai, c?p nh?t l?i
        addi $t2, $t2, 1        # T?ng bi?n ??m v�ng l?p
        j Loop                   # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateMax:
        move $t4, $t0        # C?p nh?t l?i s? l?n th? hai
        move $t5, $t1         # L?u ??a ch? c?a s? l?n th? hai
        move $t0, $t3        # C?p nh?t l?i s? l?n nh?t
        li $t1, 0            # Reset l?i ??a ch? c?a s? l?n nh?t
        add $t1, $s0, $t9    # L?u ??a ch? c?a s? l?n th? nh?t
        addi $t2, $t2, 1     # T?ng bi?n ??m v�ng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateSecondMax:
        move $t4, $t3        # C?p nh?t l?i s? l?n th? hai
        li $t5, 0            # Reset l?i ??a ch? c?a s? l?n th? hai
        add $t5, $s0, $t9    # L?u ??a ch? c?a s? l?n th? hai

        addi $t2, $t2, 1     # T?ng bi?n ??m v�ng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    ExitLoop:
        # K?t th�c ch??ng tr�nh
        # In s? l?n nh?t v� s? l?n th? hai
        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, max_msg      # Load ??a ch? c?a chu?i max_msg
        syscall

        li $v0, 1            # ??t m� h? th?ng ?? in s? nguy�n
        move $a0, $t0        # Load s? l?n nh?t v�o $a0
        syscall
	
	li $v0, 4           # ??t m� h? th?ng ?? in chu?i
        la $a0, ad_max_msg      # Load
        syscall

        li $v0, 34            # ??t m� h? th?ng ?? in
        move $a0, $t1        # Load ??a ch? s? l?n nh?t v�o $a0
        syscall
        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, second_max_msg  # Load ??a ch? c?a chu?i second_max_msg
        syscall

        li $v0, 1            # ??t m� h? th?ng ?? in s? nguy�n
        move $a0, $t4       # Load s? l?n th? hai v�o $a0
        syscall
	 
	 li $v0, 4           # ??t m� h? th?ng ?? in chu?i
        la $a0, ad_second_max_msg      # Load 
        syscall
        
	li $v0, 34            # ??t m� h? th?ng ?? in
        move $a0, $t5        # Load ??a ch? s? l?n th? hai v�o $a0
        syscall
        li $v0, 10           # K?t th�c ch??ng tr�nh
        syscall

.data
max_msg: .asciiz "S? l?n nh?t l�: "
second_max_msg: .asciiz "\nS? l?n th? hai l�: "
ad_max_msg: .asciiz "\n??a ch? s? l?n nh?t l�: "
ad_second_max_msg: .asciiz "\n??a ch?s? l?n th? hai l�: "