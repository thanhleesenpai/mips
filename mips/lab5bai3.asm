.data

	string: .space 100
	stringout: .space 100
.text
	la $s0,string
	li $v0,8
	move $a0,$s0
	li $a1,15		#max leng = 15
	syscall

	li $s1,0		# Bi?n ??m ?? dài chu?i
	
L:
	add $s2,$s1,$s0
	lb $s3,0($s2)		#load ki tu thu i
	beq $s3,$zero,E		# Ki?m tra ký t? k?t thúc
	addi $s1,$s1,1		# T?ng bi?n ??m
	j L			# L?p l?i vòng l?p
E:
	addi $s1,$s1,-1		#chieu dai chuoi = i-1
	la $t0,stringout	
	move $t1,$s1		#j=chieu dai chuoi
	li $t2,0			#k=0
	addi $s1,$s1,1
D:
	beq $t2,$s1,ED	#neu k = chieu dai chuoi + 1 ->end
	add $t3,$t2,$s0
	lb $t4,0($t3)
	add $t5,$t1,$t0
	sb $t4,0($t5)
	addi $t2,$t2,1			#k=k+1
	addi $t1,$t1,-1			#j=j-1
	j D
ED:
print:
	li 
	li $v0,4
	la $a0,stringout
	syscall
