BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// SVREGM page 448
//

start:
SVREGM:
  php       // First push the P status to retreive later
  sta TEMPA // Save A
  stx TEMPX // Save X
  sty TEMPY // Save Y
  pla       // Get P from the stack (into A this time)
  sta TEMPP
  rts       // We're done

// Variables
TEMPA: .byte 0
TEMPX: .byte 0
TEMPY: .byte 0
TEMPP: .byte 0
