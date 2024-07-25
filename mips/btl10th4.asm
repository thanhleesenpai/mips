.data
array: .word 0:10000   # mang du lieu bo nho

.text
.globl main

main:
    # Khoi tao thanh ghi
    li $t1, 50000        # so luong truy cap bo nho

loop:
    # sinh dia chi ngau nhien
    li $v0, 42           # dich vu syscall random
    li $a1,100		# gioi han tren( random tu 0 den $a1)
    syscall
    sll $t0,$a0,2 # lay so random (bo nho 4 byte)
    
    # truy cap vao bo nho ngau nhien
    lw $t2, array($t0)   # tai tu dia chi mang
    
    # giam so lan lap lai
    subi $t1, $t1, 1     # giam so luong truy cap con lai
    bgtz $t1, loop       # neu van con luot truy cap, quay lai lap

end:
    li $v0, 10           # thoat ctrinh
    syscall
