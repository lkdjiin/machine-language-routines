BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// PLOTCR page 397
//
// Print an E at (4,5)

.const PLOT = 65520 // Kernal cursor position routines
.const CHROUT = 65490

start:
  lda #147   // Clear the screen
  jsr CHROUT
  ldx #3     // Fourth row
  ldy #4     // Fifth column
  jsr PLOTCR // Position the cursor
  lda #69    // Print E
  jsr CHROUT
  rts

// Position the cursor at (Y,X).
PLOTCR:
  clc      // Clear carry to set position
  jsr PLOT // Position cursor
  rts
