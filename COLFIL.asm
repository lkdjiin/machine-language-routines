BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// COLFIL page 191
//
// Fill color RAM with purple.

.const COLRAM = 55296 // Text screen color RAM location

start:
  lda COLVAL // Get a color
  jmp COLFIL // Fill color RAM and RTS

// Fill text screen color RAM with color value in A.
COLFIL:
  ldy #250
LOOP:
  dey
  sta COLRAM,Y // 1st quarter
  sta COLRAM+250,Y // 2nd quarter
  sta COLRAM+500,Y // 3rd quarter
  sta COLRAM+750,Y // 4th quarter
  bne LOOP // All 250 bytes?
  rts

COLVAL: .byte 4 // Color purple
