li $v0, 42  # 42 is system call code to generate random int
li $a1, 100 # $a1 is where you set the upper bound
syscall     # your generated number will be at $a0

li $v0, 1   # 1 is the system call code to show an int number
syscall     # as I said your generated number is at $a0, so it will be printed