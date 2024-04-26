.data
array:  .word  5, 7, 3, 11, 8, 2, 10, 6

.text
.globl main

main:
    # Kh?i t?o bi?n
    li $t0, 0        # L?u tr? s? l?n nh?t
    li $t1, 0        # L?u tr? ??a ch? c?a s? l?n nh?t
    li $t2, 0        # Bi?n ??m vòng l?p
    li $t4, 0	     # L?u tr? s? l?n th? 2
    li $t5, 0	     # L?u tr? ??a ch? c?a s? l?n th? hai
    la $s0, array
    # Vòng l?p ?? so sánh các ph?n t?
    Loop:
        beq $t2, 8, ExitLoop  # Thoát kh?i vòng l?p khi ?ã so sánh xong t?t c? các ph?n t?
	sll $t9,$t2,2	#$t9=4*$t0
        lw $t3, array($t9)  # L?y giá tr? c?a ph?n t? th? $t2
        bgt $t3, $t0, UpdateMax  # N?u giá tr? này l?n h?n giá tr? hi?n t?i c?a s? l?n nh?t, c?p nh?t l?i
	bgt $t3, $t4, UpdateSecondMax # N?u giá tr? này l?n h?n giá tr? hi?n t?i c?a s? l?n th? hai, c?p nh?t l?i
        addi $t2, $t2, 1        # T?ng bi?n ??m vòng l?p
        j Loop                   # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateMax:
        move $t4, $t0        # C?p nh?t l?i s? l?n th? hai
        move $t5, $t1         # L?u ??a ch? c?a s? l?n th? hai
        move $t0, $t3        # C?p nh?t l?i s? l?n nh?t
        li $t1, 0            # Reset l?i ??a ch? c?a s? l?n nh?t
        add $t1, $s0, $t9    # L?u ??a ch? c?a s? l?n th? nh?t
        addi $t2, $t2, 1     # T?ng bi?n ??m vòng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateSecondMax:
        move $t4, $t3        # C?p nh?t l?i s? l?n th? hai
        li $t5, 0            # Reset l?i ??a ch? c?a s? l?n th? hai
        add $t5, $s0, $t9    # L?u ??a ch? c?a s? l?n th? hai

        addi $t2, $t2, 1     # T?ng bi?n ??m vòng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    ExitLoop:
        # K?t thúc ch??ng trình
        # In s? l?n nh?t và s? l?n th? hai
        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, max_msg      # Load ??a ch? c?a chu?i max_msg
        syscall

        li $v0, 1            # ??t mã h? th?ng ?? in s? nguyên
        move $a0, $t0        # Load s? l?n nh?t vào $a0
        syscall
	
	li $v0, 4           # ??t mã h? th?ng ?? in chu?i
        la $a0, ad_max_msg      # Load
        syscall

        li $v0, 34            # ??t mã h? th?ng ?? in
        move $a0, $t1        # Load ??a ch? s? l?n nh?t vào $a0
        syscall
        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, second_max_msg  # Load ??a ch? c?a chu?i second_max_msg
        syscall

        li $v0, 1            # ??t mã h? th?ng ?? in s? nguyên
        move $a0, $t4       # Load s? l?n th? hai vào $a0
        syscall
	 
	 li $v0, 4           # ??t mã h? th?ng ?? in chu?i
        la $a0, ad_second_max_msg      # Load 
        syscall
        
	li $v0, 34            # ??t mã h? th?ng ?? in
        move $a0, $t5        # Load ??a ch? s? l?n th? hai vào $a0
        syscall
        li $v0, 10           # K?t thúc ch??ng trình
        syscall

.data
max_msg: .asciiz "S? l?n nh?t là: "
second_max_msg: .asciiz "\nS? l?n th? hai là: "
ad_max_msg: .asciiz "\n??a ch? s? l?n nh?t là: "
ad_second_max_msg: .asciiz "\n??a ch?s? l?n th? hai là: "