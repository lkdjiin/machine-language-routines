BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BUFCLR page 125
//
// Clear keyboard buffer and fetch a keypress.


.const NDX = 198 // NDX = 208 on the 128 — number of characters in
                 // keyboard buffer
.const GETIN = 65508
.const CHROUT = 65490

start:
  jsr BUFCLR // Clear the keyboard buffer
wait:
  jsr GETIN  // Fetch the next character
  beq wait   // No keypress, so WAIT
  jsr CHROUT // Print it
  rts

// Clear the keyboard buffer.
BUFCLR:
  lda #0
  sta NDX // Set number of keys to 0
  rts
