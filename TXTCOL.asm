BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// TXTCOL page 538
//
// Set text color to green.

.const COLOR = 646 // COLOR = 241 on the 128 — foreground color for text

start:
  lda COLVAL // Get the color value
  jsr TXTCOL // and set it
  rts

// Set text color. Enter with A containing color value.
TXTCOL:
  sta COLOR // Set text color
  rts

COLVAL: .byte 5 // Color green
