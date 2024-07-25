.data
array: .word 0:10000   # mang du lieu bo nho

.text
.globl main

main:
    # Khoi tao thanh ghi
    li $t0, 0            # chi so bat dau cua mang
    li $t1, 50000        # so lan truy cap bo nho
    li $t4, 33		 # so lan truy cap bo nho trong mot chu ky 
    sll $t5,$t4,2	 # $t5=$t4x4

loop:
    # lap lai truy cap bo nho
    lw $t2, array($t0)   # tai dia chi mang
    
    # cap nhat chi so
    addi $t0, $t0, 4     # truy cap vi tri tiep theo
    bge  $t0, $t5, reset_index   # neu chi so vuot qua gioi han, dat lai chi so
    
    # giam so lan lap lai
    subi $t1, $t1, 1     # giam so luong truy cap con lai
    bgtz $t1, loop       # neu van con luot truy cap, quay lai lap
    j end

reset_index:
    li $t0, 0            # dat lai chi so
    subi $t1, $t1, 1     # giam so luong truy cap con lai
    bgtz $t1, loop       # neu van con luot truy cap, quay lai lap

end:
    li $v0, 10           # thoat chuong trinh
    syscall
