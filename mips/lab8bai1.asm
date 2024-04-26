.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
 # Bit 0 = doan a;
# Bit 1 = doan b; ...
# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.eqv ZERO 0x3F  # B?ng mã cho s? 0
    .eqv ONE 0x06   # B?ng mã cho s? 1
    .eqv TWO 0x5B   # B?ng mã cho s? 2
    .eqv THREE 0x4F # B?ng mã cho s? 3
    .eqv FOUR 0x66  # B?ng mã cho s? 4
    .eqv FIVE 0x6D  # B?ng mã cho s? 5
    .eqv SIX 0x7D   # B?ng mã cho s? 6
    .eqv SEVEN 0x07 # B?ng mã cho s? 7
    .eqv EIGHT 0x7F # B?ng mã cho s? 8
    .eqv NINE 0x6F  # B?ng mã cho s? 9
    .eqv A 0x77     # B?ng mã cho ch? A
    .eqv BE 0x7c     # B?ng mã cho ch? B
    .eqv C 0x39     # B?ng mã cho ch? C
    .eqv D 0x5E     # B?ng mã cho ch? D
    .eqv E 0x79     # B?ng mã cho ch? E
    .eqv F 0x71     # B?ng mã cho ch? F
.text
main:
 li $a0, ONE # Gia tri cho cac doan led
 jal SHOW_7SEG_LEFT # Goi thu tuc
 nop
 li $a0, A # Gia tri cho cac doan led
 jal SHOW_7SEG_RIGHT # Goi thu tuc
 nop
exit: li $v0, 10
 syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
nop
jr $ra
nop
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
nop
jr $ra
nop
