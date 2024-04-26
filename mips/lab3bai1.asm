addi $s1, $0, 0    # i = 0
addi $s2, $0, 1    # j = 1
start:
slt $t0,$s2,$s1
beq $t0,$zero,else 
else: addi $s3, $0, 5