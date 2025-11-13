BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BORCOL page 124
//
// Cycle border color while raster line is off bottom of screen.

.const EXTCOL = 53280 // Border color register
.const RASTER = 53266 // Current raster scan line
.const GETIN = 65508
.const ZP = 251

start:
GETRAS:
  lda RASTER // Check current raster line
  cmp #25    // Is it off the top of the screen?
  bcs GETRAS // No, so wait
  inc ZP     // Yes, so cycle color
  lda ZP     // A contains border color
  jsr BORCOL // Change it
  jsr GETIN  // Get a keypress
  beq GETRAS // No key, so continue to cycle
  rts

// Set border color. A holds color value.
BORCOL:
  sta EXTCOL // Set register
  rts
