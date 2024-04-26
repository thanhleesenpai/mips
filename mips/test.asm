.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
 # Bit 0 = doan a;
# Bit 1 = doan b; ...
# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
li $a0, 0x06 # Gia tri cho cac doan led
  li $t0, SEVENSEG_LEFT # Gan dia chi port
 sb $a0, 0($t0) # Gan gia tri led
 nop