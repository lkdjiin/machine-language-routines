BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// MULAD2 page 359
//
// Multiply two numbers with repeated additions (optimized version)

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
  jsr MULAD2 // Multiply the numbers
  ldx TOTAL  // low byte
  lda TOTAL + 1 // High byte
  jsr LINPRT // Print it
  lda #13    // <RETURN>
  jsr CHROUT // Print and
  jmp start  // Go back
QUIT:
  rts

MULAD2:
  lda #0        // Clear out
  sta TOTAL     // Low byte of total
  sta TOTAL + 1 // and high byte

  tay         // Zero into Y also
  ldx B2      // Check B2
  beq MULEND  // If zero, quit
  cpx B1      // Is it smaller than B1?
  bcc GOAHEAD // Yes, continue
  ldx B1      // else B1 is the counter
  beq MULEND  // If zero, no need to multiply
  ldy #1      // and Y is one instead of zero
GOAHEAD:
  lda B1, y   // Get the bigger number for adding
LOOP:
  dex         // Check for possibility X is one
  beq MULSTR  // If zero store the low byte
  clc         // else
  adc B1,y    // Add A to B1
  bcc LOOP    // If carry clear, OK
  inc TOTAL + 1 // Or add to the high byte
  jmp LOOP
MULSTR:
  sta TOTAL   // Store the low byte
MULEND:
  rts

B1: .byte 0
B2: .byte 0
TOTAL: .byte 0, 0
