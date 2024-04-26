.data
interger: .space 100
Message1: .asciiz "Nhap so nguyen:”
Message2: .asciiz "The sum of "
Message3: .asciiz " and "
Message4: .asciiz " is "
.text
	li $v0, 51
	la $a0, Message1
	syscall
	add $s0,$zero,$a0
	li $v0, 51
	la $a0, Message1
	syscall
	add $s1,$zero,$a0
	li $v0, 4
	la $a0, Message2
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, Message3
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, Message4
 	syscall 
 	add $s2,$s0,$s1
 	li $v0, 1
	move $a0, $s2
	syscall
