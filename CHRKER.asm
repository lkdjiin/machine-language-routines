BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// CHRKER page 166
//
// Accept keypress until return.

.const GETIN = 65508 // Kernal get key routine
.const CHROUT = 65490

start:
  jsr CHRKER // Get a key in A
  jsr CHROUT // Print it
  cmp #13    // Is it return?
  bne start  // If not, get another keypress
  rts

// Return a keypress in A.
CHRKER:
  jsr GETIN  // Get an ASCII keystroke
  beq CHRKER // If no keypress, then loop
  rts
