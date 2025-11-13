BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BCKCOL page 112
//
// Set background to red.

.const BGCOL0 = 53281 // Background color register 0


start:
  lda COLVAL // A contains screen background color
  jsr BCKCOL // Set it
  rts

// Set background color. Color value in A.
BCKCOL:
  sta BGCOL0 // Set background
  rts

COLVAL: .byte 2 // Color red
