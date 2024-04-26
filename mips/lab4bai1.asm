.data
s0: .word 0x12345678 # Initialize $s0 with a 32-bit number

.text
main:
    lw $s0, s0          # Load the 32-bit number into $s0
    srl $t0, $s0, 24    # Shift right logical by 24 bits to get the MSB
    sll $t1, $t0, 24    # Shift left logical by 24 bits to place MSB at LSB position
    srl $s0, $s0, 8
    sll $s0, $s0, 8 
    addi $s0,$s0, 17
    and $s0,$zero,$s0
    addi $s0,$s0,0x12345678
    sll $t2,$s0, 24
    sll $s0, $s0, 8
    srl $s0, $s0,16
    sll $s0,$s0, 8
    add $s0,$t2,$s0
    add $s0,$t0,$s0
    
  