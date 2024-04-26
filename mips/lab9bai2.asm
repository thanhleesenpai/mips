.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012 
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.data
Message: .asciiz "\nA button was pressed!\n"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
 #---------------------------------------------------------
 # Enable interrupts you expect
 #---------------------------------------------------------
# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x80 # bit 7 of = 1 to enable interrupt 
 sb $t3, 0($t1)
 #---------------------------------------------------------
 # No-end loop, main program, to demo the effective of interrupt
 #---------------------------------------------------------
Loop: nop
 nop
 nop
 nop
 b Loop # Wait for interrupt
end_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180 
 #--------------------------------------------------------
 # Processing
 #-------------------------------------------------------- 
IntSR:
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t2, OUT_ADRESS_HEXA_KEYBOARD
check0123: 
 li $t3, 0x01 # check row 4 with key C, D, E, F 
polling1: sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0,$zero,check4567
 print1: li $v0, 34 # print integer (hexa)
 syscall
 bne $a0,0x11,t1
 li $a0, 0x3f # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep1
 t1:
 bne $a0,0x21,t2
 li $a0, 0x06 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep1
  t2:
 bne $a0,0x41,t3
 li $a0, 0x5b # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep1
 t3:
 bne $a0,0xffffff81,sleep1
 li $a0, 0x4f # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 sleep1: li $a0, 100 # sleep 100ms
 li $v0, 32
syscall 
check4567:
li $t3,0x02
polling2: sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0,$zero,check89ab
 print2: li $v0, 34 # print integer (hexa)
 syscall
  bne $a0,0x12,t5
 li $a0, 0x66 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep2
 t5:
 bne $a0,0x22,t6
 li $a0, 0x6d # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep2
  t6:
 bne $a0,0x42,t7
 li $a0, 0x7d# Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep2
 t7:
 bne $a0,0xffffff82,sleep2
 li $a0, 0x07 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 sleep2: li $a0, 100 # sleep 100ms
 li $v0, 32
syscall 
check89ab:
li $t3,0x04
polling3: sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0,$zero,checkcdef
 print3: li $v0, 34 # print integer (hexa)
 syscall
   bne $a0,0x14,t9
 li $a0, 0x7f # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep3
 t9:
 bne $a0,0x24,ta
 li $a0, 0x6f # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep3
  ta:
 bne $a0,0x44,tb
 li $a0, 0x77# Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep3
 tb:
 bne $a0,0xffffff84,sleep3
 li $a0, 0x7c # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep3
 sleep3: li $a0, 100 # sleep 100ms
 li $v0, 32
syscall 
checkcdef:
li $t3,0x08
polling4: sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0,$zero,continue
 print4: li $v0, 34 # print integer (hexa)
 syscall
   bne $a0,0x18,td
 li $a0, 0x39 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep4
 td:
 bne $a0,0x28,te
 li $a0, 0x5e # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep4
  te:
 bne $a0,0x48,tf
 li $a0, 0x79# Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep4
 tf:
 bne $a0,0xffffff88,sleep4
 li $a0, 0x71 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop
 j sleep4
 sleep4: li $a0, 100 # sleep 100ms
 li $v0, 32
syscall 
continue:
 addi $v0, $zero, 4 # show message 
 la $a0, Message
 syscall
 #--------------------------------------------------------
 # Evaluate the return address of main routine
 # epc <= epc + 4
 #--------------------------------------------------------
 next_pc:mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 addi $at, $at, 4 # $at = $at + 4 (next instruction)
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
 li $t3, 0x80
 sb $t3, 0($t1)
return: eret # Return from exception