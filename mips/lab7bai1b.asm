.data
input_string: .space 100      # Chu?i ?? l?u ??u vào
output_array: .space 120     # M?ng ?? l?u các s? (t?i ?a 30 s?, m?i s? chi?m 4 byte)

.text
main:
    # Nh?p chu?i t? bàn phím
    li $v0, 8            # syscall 8: ??c chu?i
    la $a0, input_string  # ??a ch? c?a chu?i ??u vào
    li $a1, 100           # ?? dài t?i ?a c?a chu?i
    syscall

    # L?p qua chu?i ??u vào ?? ??c t?ng s?
    la $t0, input_string  # ??a ch? b?t ??u c?a chu?i ??u vào
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?
    li $t4, 0            # Bi?n ??m s? ?ã nh?p

read_loop:
    lb $t2, 0($t0)       # ??c m?t ký t? t? chu?i ??u vào
    beq $t2, 0, end_read  # N?u g?p ký t? k?t thúc chu?i (\0) thì k?t thúc
    beq $t2, 32, skip_space # N?u là d?u cách thì b? qua

    # Chuy?n ký t? thành s?
    sub $t2, $t2, 48     # Chuy?n t? mã ASCII sang s? nguyên
    lw $t3, 0($t1)       # ??c s? hi?n t?i t? m?ng
    sll $t3, $t3, 3      # Nhân 4 ?? d?ch bit sang trái 2 l?n (t??ng ???ng * 4)
    add $t3, $t3, $t2    # Thêm s? m?i vào m?ng
    sw $t3, 0($t1)       # L?u s? vào m?ng
    addi $t0, $t0, 1     # T?ng con tr? c?a chu?i ??u vào
    addi $t1, $t1, 4     # D?ch con tr? c?a m?ng 4 byte (kích th??c c?a m?i s?)
    addi $t4, $t4, 1     # T?ng bi?n ??m s? ?ã nh?p
    beq $t4, 30, end_read # N?u ?ã nh?p ?? 30 s? thì k?t thúc
    j read_loop

skip_space:
    addi $t0, $t0, 1     # B? qua d?u cách
    j read_loop
end_read:
    # S?p x?p m?ng output_array b?ng Bubble Sort
    li $t5, 30          # S? l?n l?p t?i ?a (30 s?)
    li $t6, 1           # Bi?n ?ánh d?u có thay ??i trong l?n l?p hi?n t?i
sort_loop:
    li $t7, 0           # Bi?n .data
input_string: .space 100      # Chu?i ?? l?u ??u vào
output_array: .space 120     # M?ng ?? l?u các s? (t?i ?a 30 s?, m?i s? chi?m 4 byte)

.text
main:
    # Nh?p chu?i t? bàn phím
    li $v0, 8            # syscall 8: ??c chu?i
    la $a0, input_string  # ??a ch? c?a chu?i ??u vào
    li $a1, 100           # ?? dài t?i ?a c?a chu?i
    syscall

    # L?p qua chu?i ??u vào ?? ??c t?ng s?
    la $t0, input_string  # ??a ch? b?t.data
array:  .word  5, 7, 3, 11, 8, 2, 10, 6

.text
.globl main

main:
    # Kh?i t?o bi?n
    li $t0, 1000        # L?u tr? s? nh? nh?t
    li $t1, 0        # L?u tr? ??a ch? c?a s? nh? nh?t
    li $t2, 0        # Bi?n ??m vòng l?p
    li $t4, 1000        # L?u tr? s? nh? th? hai
    li $t5, 0        # L?u tr? ??a ch? c?a s? nh? th? hai
    la $s0, array

    # Vòng l?p ?? so sánh các ph?n t?
    Loop:
        beq $t2, 8, ExitLoop  # Thoát kh?i vòng l?p khi ?ã so sánh xong t?t c? các ph?n t?
        sll $t9, $t2, 2       # $t9 = 4 * $t2
        lw $t3, array($t9)    # L?y giá tr? c?a ph?n t? th? $t2

        blt $t3, $t0, UpdateMin         # N?u giá tr? này nh? h?n giá tr? hi?n t?i c?a s? nh? nh?t, c?p nh?t l?i
        blt $t3, $t4, UpdateSecondMin   # N?u giá tr? này nh? h?n giá tr? hi?n t?i c?a s? nh? th? hai, c?p nh?t l?i

        addi $t2, $t2, 1     # T?ng bi?n ??m vòng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateMin:
        move $t4, $t0        # C?p nh?t l?i s? nh? th? hai
        move $t5, $t1        # L?u ??a ch? c?a s? nh? th? hai
        move $t0, $t3        # C?p nh?t l?i s? nh? nh?t
        li $t1, 0            # Reset l?i ??a ch? c?a s? nh? nh?t
        add $t1, $s0, $t9    # L?u ??a ch? c?a s? nh? th? nh?t

        addi $t2, $t2, 1     # T?ng bi?n ??m vòng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    UpdateSecondMin:
        move $t4, $t3        # C?p nh?t l?i s? nh? th? hai
        li $t5, 0            # Reset l?i ??a ch? c?a s? nh? th? hai
        add $t5, $s0, $t9    # L?u ??a ch? c?a s? nh? th? hai

        addi $t2, $t2, 1     # T?ng bi?n ??m vòng l?p
        j Loop               # Quay l?i ki?m tra ph?n t? ti?p theo

    ExitLoop:
        # K?t thúc ch??ng trình
        # In s? nh? nh?t và s? nh? th? hai
        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, min_msg      # Load ??a ch? c?a chu?i min_msg
        syscall

        li $v0, 1            # ??t mã h? th?ng ?? in s? nguyên
        move $a0, $t0        # Load s? nh? nh?t vào $a0
        syscall

        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, ad_min_msg   # Load ??a ch? c?a chu?i ad_min_msg
        syscall

        li $v0, 34           # ??t mã h? th?ng ?? in
        move $a0, $t1        # Load ??a ch? s? nh? nh?t vào $a0
        syscall

        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, second_min_msg  # Load ??a ch? c?a chu?i second_min_msg
        syscall

        li $v0, 1            # ??t mã h? th?ng ?? in s? nguyên
        move $a0, $t4        # Load s? nh? th? hai vào $a0
        syscall

        li $v0, 4            # ??t mã h? th?ng ?? in chu?i
        la $a0, ad_second_min_msg  # Load ??a ch? c?a chu?i ad_second_min_msg
        syscall

        li $v0, 34           # ??t mã h? th?ng ?? in
        move $a0, $t5        # Load ??a ch? s? nh? th? hai vào $a0
        syscall

        li $v0, 10           # K?t thúc ch??ng trình
        syscall

.data
min_msg: .asciiz "S? nh? nh?t là: "
second_min_msg: .asciiz "\nS? nh? th? hai là: "
ad_min_msg: .asciiz "\n??a ch? s? nh? nh?t là: "
ad_second_min_msg: .asciiz "\n??a ch? s? nh? th? hai là: "
 ??u c?a chu?i ??u vào
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?
    li $t4, 0            # Bi?n ??m s? ?ã nh?p

read_loop:
    lb $t2, 0($t0)       # ??c m?t ký t? t? chu?i ??u vào
    beq $t2, 0, end_read  # N?u g?p ký t? k?t thúc chu?i (\0) thì k?t thúc
    beq $t2, 32, skip_space # N?u là d?u cách thì b? qua

    # Chuy?n ký t? thành s?
    sub $t2, $t2, 48     # Chuy?n t? mã ASCII sang s? nguyên
    lw $t3, 0($t1)       # ??c s? hi?n t?i t? m?ng
    sll $t3, $t3, 3      # Nhân 4 ?? d?ch bit sang trái 2 l?n (t??ng ???ng * 4)
    add $t3, $t3, $t2    # Thêm s? m?i vào m?ng
    sw $t3, 0($t1)       # L?u s? vào m?ng
    addi $t0, $t0, 1     # T?ng con tr? c?a chu?i ??u vào
    addi $t1, $t1, 4     # D?ch con tr? c?a m?ng 4 byte (kích th??c c?a m?i s?)
    addi $t4, $t4, 1     # T?ng bi?n ??m s? ?ã nh?p
    beq $t4, 30, end_read # N?u ?ã nh?p ?? 30 s? thì k?t thúc
    j read_loop

skip_space:
    addi $t0, $t0, 1     # B? qua d?u cách
    j read_loop
end_read:
    # S?p x?p m?ng output_array b?ng Bubble Sort
    li $t5, 30          # S? l?n l?p t?i ?a (30 s?)
    li $t6, 1           # Bi?n ?ánh d?u có thay ??i trong l?n l?p hi?n t?i
sort_loop:
    li $t7, 0           # Bi?n ?ánh d?u không có thay ??i trong l?n l?p hi?n t?i
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?

    # L?p qua các ph?n t? c?n s?p x?p
    li $t4, 1           # Bi?n ??m
inner_loop:
    lw $t8, 0($t1)      # L?y s? hi?n t?i
    lw $t9, 4($t1)      # L?y s? k? ti?p
    ble $t8, $t9, no_swap  # N?u s? hi?n t?i nh? h?n ho?c b?ng s? k? ti?p thì không c?n ??i ch?

    # Hoán ??i hai s?
    sw $t9, 0($t1)
    sw $t8, 4($t1)
    li $t7, 1           # ?ánh d?u có thay ??i
no_swap:
    addi $t1, $t1, 4    # Di chuy?n ??n ph?n t? k? ti?p
    addi $t4, $t4, 1    # T?ng bi?n ??m
    bne $t4, $t5, inner_loop # L?p l?i n?u ch?a l?p ?? s? l?n

    # Ki?m tra xem có c?n l?p l?i Bubble Sort n?a không
    bne $t7, $zero, sort_loop

    # K?t thúc ch??ng trình
    li $v0, 10            # syscall 10: K?t thúc ch??ng trình
    syscall
?ánh d?u không có thay ??i trong l?n l?p hi?n t?i
    la $t1, output_array # ??a ch? b?t ??u c?a m?ng s?

    # L?p qua các ph?n t? c?n s?p x?p
    li $t4, 1           # Bi?n ??m
inner_loop:
    lw $t8, 0($t1)      # L?y s? hi?n t?i
    lw $t9, 4($t1)      # L?y s? k? ti?p
    ble $t8, $t9, no_swap  # N?u s? hi?n t?i nh? h?n ho?c b?ng s? k? ti?p thì không c?n ??i ch?

    # Hoán ??i hai s?
    sw $t9, 0($t1)
    sw $t8, 4($t1)
    li $t7, 1           # ?ánh d?u có thay ??i
no_swap:
    addi $t1, $t1, 4    # Di chuy?n ??n ph?n t? k? ti?p
    addi $t4, $t4, 1    # T?ng bi?n ??m
    bne $t4, $t5, inner_loop # L?p l?i n?u ch?a l?p ?? s? l?n

    # Ki?m tra xem có c?n l?p l?i Bubble Sort n?a không
    bne $t7, $zero, sort_loop

    # K?t thúc ch??ng trình
    li $v0, 10            # syscall 10: K?t thúc ch??ng trình
    syscall
