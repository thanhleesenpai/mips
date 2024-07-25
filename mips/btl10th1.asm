.data
data:    .word     0 : 90000     # ma tran 16x16(tuong trung cho du lieu)
.text
         li       $t0, 300       # $t0 = so hang
         li       $t1, 300       # $t1 = so cot
         move     $s0, $zero     # $s0 = bien dem so hang
         move     $s1, $zero     # $s1 = bien dem so cot
         move     $t2, $zero     # $t2 = gia tri can luu

loop:    mult     $s0, $t1       
         mflo     $s2            # $s2 = bien dem so hang*so cot
         add      $s2, $s2, $s1  # $s2 += bien dem so cot
         sll      $s2, $s2, 2    # $s2 *= 4 dich trai 2 bit($s2=$s2*4)
         sw       $t2, data($s2) # luu gia tri vào data
         addi     $t2, $t2, 1    # tang gia tri can luu

         addi     $s1, $s1, 1    # tang bien dem cot
         bne      $s1, $t1, loop # neu chua het hang thi quay lai loop
         move     $s1, $zero     # reset bien dem cot
         addi     $s0, $s0, 1    # tang bien dem hang
         bne      $s0, $t0, loop # neu bien dem hang chua bang so hang thi quay lai loop

         li       $v0, 10        # thoat ctrinh
         syscall                
         