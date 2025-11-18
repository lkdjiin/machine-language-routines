BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// NUMOUT page 378
//
// Print two-byte integer values

.const LINPRT = 48589 // LINPRT = 36402 on the 128

start:
  ldx INTGER     // Low byte of integer 85
  lda INTGER + 1 // High byte of 85
  jmp NUMOUT     // Print the number and RTS 

// Print the two-byte integer in X (low byte) and A (high byte).
NUMOUT:
  jmp LINPRT // Print the number and RTS

INTGER: .word 85
