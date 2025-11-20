BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// SIDCLR page 469
//
// Produce an explosion sound

.const FRELO1 = 54272 // Starting address of the SID chip

start:
SIDCLR:
  lda #0  // Fill with zeros
  ldy #24 // as the offset from FRELO1
SIDLOP:
  sta FRELO1,y // Store zero in each SID register
  dey          // for next lower address
  bpl SIDLOP   // Fill 25 bytes
  rts
