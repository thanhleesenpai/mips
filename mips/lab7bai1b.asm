.data
input_string: .space 100      # Chu?i ?? l?u ??u v�o
output_array: .space 120     # M?ng ?? l?u c�c s? (t?i ?a 30 s?, m?i s? chi?m 4 byte)

.text
main:
    # Nh?p chu?i t? b�n ph�m
    li $v0, 8            # syscall 8: ??c chu?i
    la $a0, input_string  # ??a ch? c?a chu?i ??u v�o
    li $a1, 100           # ?? d�i t?i ?a c?a chu?i
    syscall

    # L?p qua chu?i ??u v�o ?? ??c t?ng s?
    la $t0, input_string  # ??a ch? b?t ??u c?a chu?i ??u v�o
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?
    li $t4, 0            # Bi?n ??m s? ?� nh?p

read_loop:
    lb $t2, 0($t0)       # ??c m?t k� t? t? chu?i ??u v�o
    beq $t2, 0, end_read  # N?u g?p k� t? k?t th�c chu?i (\0) th� k?t th�c
    beq $t2, 32, skip_space # N?u l� d?u c�ch th� b? qua

    # Chuy?n k� t? th�nh s?
    sub $t2, $t2, 48     # Chuy?n t? m� ASCII sang s? nguy�n
    lw $t3, 0($t1)       # ??c s? hi?n t?i t? m?ng
    sll $t3, $t3, 3      # Nh�n 4 ?? d?ch bit sang tr�i 2 l?n (t??ng ???ng * 4)
    add $t3, $t3, $t2    # Th�m s? m?i v�o m?ng
    sw $t3, 0($t1)       # L?u s? v�o m?ng
    addi $t0, $t0, 1     # T?ng con tr? c?a chu?i ??u v�o
    addi $t1, $t1, 4     # D?ch con tr? c?a m?ng 4 byte (k�ch th??c c?a m?i s?)
    addi $t4, $t4, 1     # T?ng bi?n ??m s? ?� nh?p
    beq $t4, 30, end_read # N?u ?� nh?p ?? 30 s? th� k?t th�c
    j read_loop

skip_space:
    addi $t0, $t0, 1     # B? qua d?u c�ch
    j read_loop
end_read:
    # S?p x?p m?ng output_array b?ng Bubble Sort
    li $t5, 30          # S? l?n l?p t?i ?a (30 s?)
    li $t6, 1           # Bi?n ?�nh d?u c� thay ??i trong l?n l?p hi?n t?i
sort_loop:
    li $t7, 0           # Bi?n .data
input_string: .space 100      # Chu?i ?? l?u ??u v�o
output_array: .space 120     # M?ng ?? l?u c�c s? (t?i ?a 30 s?, m?i s? chi?m 4 byte)

.text
main:
    # Nh?p chu?i t? b�n ph�m
    li $v0, 8            # syscall 8: ??c chu?i
    la $a0, input_string  # ??a ch? c?a chu?i ??u v�o
    li $a1, 100           # ?? d�i t?i ?a c?a chu?i
    syscall

    # L?p qua chu?i ??u v�o ?? ??c t?ng s?
    la $t0, input_string  # ??a ch? b?t.data
array:  .word  5, 7, 3, 11, 8, 2, 10, 6

.text
.globl main

main:
    # Kh?i t?o bi?n
    li $t0, 1000        # L?u tr? s? nh? nh?t
    li $t1, 0        # L?u tr? ??a ch? c?a s? nh? nh?t
    li $t2, 0        # Bi?n ??m v�ng l?p
    li $t4, 1000        # L?u tr? s? nh? th? hai
    li $t5, 0        # L?u tr? ??a ch? c?a s? nh? th? hai
    la $s0, array

    # V�ng l?p ?? so s�nh c�c ph?n t?
    Loop:
        beq $t2, 8, ExitLoop  # Tho�t kh?i v�ng l?p khi ?� so s�nh xong t?t c? c�c ph?n t?
        sll $t9, $t2, 2       # $t9 = 4 * $t2
        lw $t3, array($t9)    # L?y gi� tr? c?a ph?n t? th? $t2

        blt $t3, $t0, UpdateMin         # N?u gi� tr? n�y nh? h?n gi� tr? hi?n t?i c?a s? nh? nh?t, c?p nh?t l?i
        blt $t3, $t4, UpdateSecondMin   # N?u gi� tr? n�y nh? h?n gi� tr? hi?n t?i c?a s? nh? th? hai, c?p nh?t l?i

        addi $t2, $t2, 1     # T?ng bi?n ??m v�ng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateMin:
        move $t4, $t0        # C?p nh?t l?i s? nh? th? hai
        move $t5, $t1        # L?u ??a ch? c?a s? nh? th? hai
        move $t0, $t3        # C?p nh?t l?i s? nh? nh?t
        li $t1, 0            # Reset l?i ??a ch? c?a s? nh? nh?t
        add $t1, $s0, $t9    # L?u ??a ch? c?a s? nh? th? nh?t

        addi $t2, $t2, 1     # T?ng bi?n ??m v�ng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateSecondMin:
        move $t4, $t3        # C?p nh?t l?i s? nh? th? hai
        li $t5, 0            # Reset l?i ??a ch? c?a s? nh? th? hai
        add $t5, $s0, $t9    # L?u ??a ch? c?a s? nh? th? hai

        addi $t2, $t2, 1     # T?ng bi?n ??m v�ng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    ExitLoop:
        # K?t th�c ch??ng tr�nh
        # In s? nh? nh?t v� s? nh? th? hai
        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, min_msg      # Load ??a ch? c?a chu?i min_msg
        syscall

        li $v0, 1            # ??t m� h? th?ng ?? in s? nguy�n
        move $a0, $t0        # Load s? nh? nh?t v�o $a0
        syscall

        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, ad_min_msg   # Load ??a ch? c?a chu?i ad_min_msg
        syscall

        li $v0, 34           # ??t m� h? th?ng ?? in
        move $a0, $t1        # Load ??a ch? s? nh? nh?t v�o $a0
        syscall

        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, second_min_msg  # Load ??a ch? c?a chu?i second_min_msg
        syscall

        li $v0, 1            # ??t m� h? th?ng ?? in s? nguy�n
        move $a0, $t4        # Load s? nh? th? hai v�o $a0
        syscall

        li $v0, 4            # ??t m� h? th?ng ?? in chu?i
        la $a0, ad_second_min_msg  # Load ??a ch? c?a chu?i ad_second_min_msg
        syscall

        li $v0, 34           # ??t m� h? th?ng ?? in
        move $a0, $t5        # Load ??a ch? s? nh? th? hai v�o $a0
        syscall

        li $v0, 10           # K?t th�c ch??ng tr�nh
        syscall

.data
min_msg: .asciiz "S? nh? nh?t l�: "
second_min_msg: .asciiz "\nS? nh? th? hai l�: "
ad_min_msg: .asciiz "\n??a ch? s? nh? nh?t l�: "
ad_second_min_msg: .asciiz "\n??a ch? s? nh? th? hai l�: "
 ??u c?a chu?i ??u v�o
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?
    li $t4, 0            # Bi?n ??m s? ?� nh?p

read_loop:
    lb $t2, 0($t0)       # ??c m?t k� t? t? chu?i ??u v�o
    beq $t2, 0, end_read  # N?u g?p k� t? k?t th�c chu?i (\0) th� k?t th�c
    beq $t2, 32, skip_space # N?u l� d?u c�ch th� b? qua

    # Chuy?n k� t? th�nh s?
    sub $t2, $t2, 48     # Chuy?n t? m� ASCII sang s? nguy�n
    lw $t3, 0($t1)       # ??c s? hi?n t?i t? m?ng
    sll $t3, $t3, 3      # Nh�n 4 ?? d?ch bit sang tr�i 2 l?n (t??ng ???ng * 4)
    add $t3, $t3, $t2    # Th�m s? m?i v�o m?ng
    sw $t3, 0($t1)       # L?u s? v�o m?ng
    addi $t0, $t0, 1     # T?ng con tr? c?a chu?i ??u v�o
    addi $t1, $t1, 4     # D?ch con tr? c?a m?ng 4 byte (k�ch th??c c?a m?i s?)
    addi $t4, $t4, 1     # T?ng bi?n ??m s? ?� nh?p
    beq $t4, 30, end_read # N?u ?� nh?p ?? 30 s? th� k?t th�c
    j read_loop

skip_space:
    addi $t0, $t0, 1     # B? qua d?u c�ch
    j read_loop
end_read:
    # S?p x?p m?ng output_array b?ng Bubble Sort
    li $t5, 30          # S? l?n l?p t?i ?a (30 s?)
    li $t6, 1           # Bi?n ?�nh d?u c� thay ??i trong l?n l?p hi?n t?i
sort_loop:
    li $t7, 0           # Bi?n ?�nh d?u kh�ng c� thay ??i trong l?n l?p hi?n t?i
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?

    # L?p qua c�c ph?n t? c?n s?p x?p
    li $t4, 1           # Bi?n ??m
inner_loop:
    lw $t8, 0($t1)      # L?y s? hi?n t?i
    lw $t9, 4($t1)      # L?y s? k? ti?p
    ble $t8, $t9, no_swap  # N?u s? hi?n t?i nh? h?n ho?c b?ng s? k? ti?p th� kh�ng c?n ??i ch?

    # Ho�n ??i hai s?
    sw $t9, 0($t1)
    sw $t8, 4($t1)
    li $t7, 1           # ?�nh d?u c� thay ??i
no_swap:
    addi $t1, $t1, 4    # Di chuy?n ??n ph?n t? k? ti?p
    addi $t4, $t4, 1    # T?ng bi?n ??m
    bne $t4, $t5, inner_loop # L?p l?i n?u ch?a l?p ?? s? l?n

    # Ki?m tra xem c� c?n l?p l?i Bubble Sort n?a kh�ng
    bne $t7, $zero, sort_loop

    # K?t th�c ch??ng tr�nh
    li $v0, 10            # syscall 10: K?t th�c ch??ng tr�nh
    syscall
?�nh d?u kh�ng c� thay ??i trong l?n l?p hi?n t?i
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?

    # L?p qua c�c ph?n t? c?n s?p x?p
    li $t4, 1           # Bi?n ??m
inner_loop:
    lw $t8, 0($t1)      # L?y s? hi?n t?i
    lw $t9, 4($t1)      # L?y s? k? ti?p
    ble $t8, $t9, no_swap  # N?u s? hi?n t?i nh? h?n ho?c b?ng s? k? ti?p th� kh�ng c?n ??i ch?

    # Ho�n ??i hai s?
    sw $t9, 0($t1)
    sw $t8, 4($t1)
    li $t7, 1           # ?�nh d?u c� thay ??i
no_swap:
    addi $t1, $t1, 4    # Di chuy?n ??n ph?n t? k? ti?p
    addi $t4, $t4, 1    # T?ng bi?n ??m
    bne $t4, $t5, inner_loop # L?p l?i n?u ch?a l?p ?? s? l?n

    # Ki?m tra xem c� c?n l?p l?i Bubble Sort n?a kh�ng
    bne $t7, $zero, sort_loop

    # K?t th�c ch??ng tr�nh
    li $v0, 10            # syscall 10: K?t th�c ch??ng tr�nh
    syscall
