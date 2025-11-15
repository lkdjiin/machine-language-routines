BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// MULAD1 page 357
//
// Multiply two numbers with successive adds

.const LINPRT = $BDCD // LINPRT = $8E32 on the 128 — ROM routine to print
                      // a number
.const GETIN = $FFE4
.const CHROUT = $FFD2

start:
  jsr GETIN // Get a key
  beq start // Wait until there's one there
  cmp #81   // Check for Q (quit)
  beq QUIT
  sta B1    // Store it in byte 1
M2:
  jsr GETIN // Get another key
  beq M2
  cmp #81   // Check Q again
  beq QUIT
  sta B2    // Store in byte 2
  ldx B1
  lda #0
  jsr LINPRT // Print number 1
  lda #42    // The * character
  jsr CHROUT // Print it
  ldx B2     // Second number
  lda #0
  jsr LINPRT // Print it also
  lda #61    // Equal sign
  jsr CHROUT // Print it
  jsr MULAD1 // Multiply the numbers
  ldx TOTAL  // low byte
  lda TOTAL + 1 // High byte
  jsr LINPRT // Print it
  lda #13    // <RETURN>
  jsr CHROUT // Print and
  jmp start  // Go back
QUIT:
  rts

MULAD1:
  lda #0        // Clear out
  sta TOTAL     // Low byte of total
  sta TOTAL + 1 // and high byte

  ldx B1        // The counter for repeated adds
  beq MULEND    // If zero, no addition
  clc
  lda B2        // Second number (which will be added)
  beq MULEND    // If zero, no operation is necessary
MULLOP:
  dex           // Decrement X first, in case it's a 1
  beq MULSTR    // If zero, store the result in total (low byte)
  clc           // Get ready
  adc B2        // and add A to B2
  bcc MULLOP    // If carry is clear, no overflow to the high byte
  inc TOTAL + 1 // else add one to hight byte
  jmp MULLOP    // and go back
MULSTR:
  sta TOTAL     // Store the low byte (high byte is OK)
MULEND:
  rts

B1: .byte 0
B2: .byte 0
TOTAL: .byte 0, 0
