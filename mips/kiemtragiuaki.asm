.data
A: .word -2, 6, -1, 3, -5
.text
li $t1, 10 #1
li $t0, 0x000000ab #2
sb $t1, A($t0) #3