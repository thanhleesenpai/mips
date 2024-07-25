.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012 
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014 
.eqv COUNTER 0xFFFF0013 # Time Counter
.eqv MASK_CAUSE_COUNTER 0x00000400 # Bit 10: Counter interrupt
.eqv MASK_CAUSE_KEYMATRIX 0x00000800 # Bit 11: Key matrix interrupt
.data
msg_keypress: .asciiz "It is interrupted Keyboard.\n"
msg_counter: .asciiz "It is interrupted by Counter "
msg_counter1: .asciiz " times. \n"
msg_counter2: .asciiz ""
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
 #---------------------------------------------------------
 # Enable the interrupt you expect
 #---------------------------------------------------------
 # Enable the interrupt of Key matrix 4x4 of Digital Lab Sim
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x80 # bit 7 = 1 to enable interrupt 
 sb $t3, 0($t1)
 # Enable the interrupt of TimeCounter of Digital Lab Sim
 li $t1, COUNTER 
 sb $t1, 0($t1)
 
 #---------------------------------------------------------
 # Loop to print a sequence of numbers
 #---------------------------------------------------------
Loop: nop
 nop
 nop 
sleep: addi $v0,$zero,32 #BUG: must sleep to wait for Time Counter 
 li $a0,200 #sleep 300 ms
 syscall
 nop #WARNING: nop is mandatory here. 
 b Loop
end_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180 
IntSR: #--------------------------------------------------------
 # Temporary disable interrupt
 #-------------------------------------------------------- 
dis_int:li $t1, COUNTER #BUG: must disable with Time Counter
 sb $zero, 0($t1)
 # no need to disable keyboard matrix interrupt
 #--------------------------------------------------------
 # Processing
 #--------------------------------------------------------
 get_caus:mfc0 $t1, $13 # $t1 = Coproc0.cause
IsCount:li $t2, MASK_CAUSE_COUNTER# if Cause value confirm Counter..
 and $at, $t1,$t2
 beq $at,$t2, Counter_Intr 
IsKeyMa:li $t2, MASK_CAUSE_KEYMATRIX # if Cause value confirm Key..
 and $at, $t1,$t2
 beq $at,$t2, Keymatrix_Intr 
others: j end_process # other cases
Keymatrix_Intr: li $v0, 4 # Processing Key Matrix Interrupt 
 la $a0, msg_keypress
 syscall
 check0123: 
 get_cod1:li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x81 # check row 4 and re-enable bit 7
 sb $t3, 0($t1) # must reassign expected row
 li $t1, OUT_ADRESS_HEXA_KEYBOARD
 lb $a0, 0($t1)
 beq $a0,$zero,check4567
 j prn_cod
check4567:
get_cod2:li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x82 # check row 4 and re-enable bit 7
 sb $t3, 0($t1) # must reassign expected row
 li $t1, OUT_ADRESS_HEXA_KEYBOARD
 lb $a0, 0($t1)
 beq $a0,$zero,check89ab
 j prn_cod
check89ab:
get_cod3:li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x84 # check row 4 and re-enable bit 7
 sb $t3, 0($t1) # must reassign expected row
 li $t1, OUT_ADRESS_HEXA_KEYBOARD
 lb $a0, 0($t1)
 beq $a0,$zero,checkcdef
 j prn_cod
checkcdef:
get_cod4:li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x88 # check row 4 and re-enable bit 7
 sb $t3, 0($t1) # must reassign expected row
 li $t1, OUT_ADRESS_HEXA_KEYBOARD
 lb $a0, 0($t1)
prn_cod:li $v0,34 
 syscall
 li $v0,11
 li $a0,'\n' # print endofline
 syscall
 j end_process 
Counter_Intr: li $v0, 4 # Processing Counter Interrupt 
 la $a0, msg_counter
 syscall
 li $v0,1
 addi $t9,$t9,1
 add $a0, $t9,$zero
 syscall
 li $v0, 4
 la $a0, msg_counter1
 syscall
  li $v0, 4
 la $a0, msg_counter2
 syscall
 j end_process 
end_process: 
 mtc0 $zero, $13 # Must clear cause reg 
en_int: #--------------------------------------------------------
 # Re-enable interrupt
 #--------------------------------------------------------
li $t1, COUNTER
 sb $t1, 0($t1) 
 #--------------------------------------------------------
 # Evaluate the return address of main routine
 # epc <= epc + 4
 #--------------------------------------------------------
next_pc:mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 addi $at, $at, 4 # $at = $at + 4 (next instruction)
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at 
return: eret # Return from exception
