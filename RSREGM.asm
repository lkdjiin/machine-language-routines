BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// RSREGM page 448
//
// Restore registers from memory

start:
RSREGM:
  lda TEMPP // First get the P status register
  pha       // Push it temporarily
  lda TEMPA // Get A
  ldx TEMPX // Get X
  ldy TEMPY // Get Y
  plp       // Get P from the stack (where it was pushed from A)
  rts       // We're done

// Variables
TEMPA: .byte 0
TEMPX: .byte 0
TEMPY: .byte 0
TEMPP: .byte 0
