.data
s0: .word 0x12345678 # Initialize $s0 with a 32-bit number
store: .word 0x00000000
.text
    li $v0, 5 #System call code to read an integer from the keyboard.
    syscall #$v0 saves the integer.
    lw $s0, s0          # Load the 32-bit number into $s0
    srlv $s0,$s0,$v0
    li $t0,17
    li $t1,32
    sub $t0,$t1,$t0
    sllv $s0,$s0,$t0
    srlv $s0,$s0,$t0
    sw $s0,store