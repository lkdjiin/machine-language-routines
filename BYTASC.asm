BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BYTASC page 131
//
// Converts the one-byte number in A to ASCII and prints it.

.const CHROUT = 65490
.const GETIN = 65508
.const JIFFY = 162
.const ZP = 251

start:
LOOP:
  lda JIFFY  // Get a jiffy
  jsr BYTASC // Convert value to ASCII and print it
  lda #32    // Print a SPACE
  jsr CHROUT
  lda #13    // Print a RETURN
  jsr CHROUT
  jsr GETIN  // Check for keypress
  beq LOOP   // If no key, continue
  rts

// Converts the one-byte number in A to ASCII and prints it.
BYTASC:
  ldx #48    // Initialize place-holder table (DIGITS) with ASCII 0
  stx DIGITS
  stx DIGITS+1
  stx DIGITS+2
  ldy #0     // As an index
  sty ZEROFL // Initialize ZEROFL
NMLOOP:
  ldx DIGITS,y // Load with ASCII counter for a particular digit's place
  beq DONE     // If we've reached the last digit's place, go
               // print the number
  sec
SUBLOP:
  sbc TB1SUB,y // Substract corresponding table value from A
  inx          // Increment ASCII counter for a particular digit's place
  bcs SUBLOP   // If A is still zero or above
  adc TB1SUB,y // We substracted one time too many, so add subtrahend
               // back to A
  dex          // Since one time too many
  pha          // Temporarily save A
  txa
  sta DIGITS,y // Store respective digit to place-holder table
  pla          // Restore A
  iny          // For next digit's place
  bne NMLOOP   // Branch always
DONE:
  ldy #255     // As index in the number
PRTLOP:
  iny          // Start with first digit
  lda DIGITS,y
  beq OUT      // If we're at the end of the table, leave routine
  ldx ZEROFL   // Check ZEROFL to see if a nonzero digit has been printed
  bne PRINT    // If so, go print the digit
  cmp #48      // Check for leading zeros
  beq PRTLOP   // If leading zero occurs, get the next digit
  sta ZEROFL   // Store nonzero digit
PRINT:
  jsr CHROUT   // Print each digit
  jmp PRTLOP   // and go to next place
OUT:
  lda ZEROFL   // Determine if the number is 000
  bne EXIT     // If not, then return
  lda #48      // Print a zero
  jsr CHROUT
EXIT:
  rts

DIGITS:
.byte 0,0,0 // For storing ASCII counter values for each digit's place
.byte 0     // Digit's terminator byte
TB1SUB:
.byte 100,10,1 // Table of one-byte subtrahends for each digit's place
ZEROFL:
.byte 0 // ZEROFL is nonzero if a nonzero digit has printed
