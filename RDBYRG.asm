BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// RNDBYT page 428
//
// Generate ten random byte values using SID chip voice 3 in a range (30-45)
// and print them.

.const CHROUT = 65490
.const LINPRT = 48589
.const FREHI3 = 54287 // Voice 3 frequency control register (high byte)
.const VCREG3 = 54290 // Voice 3 control register
.const SIGVOL = 54296 // Volume and filter select register
.const RANDOM = 54299 // Oscillator 3/random number generator

start:
  jsr RDINIT   // Initialize SID voice 3 for random numbers
  lda #10      // Initialize counter for ten random numbers
  sta TEMCNT   // Save counter
loop:
  jsr RDBYRG   // Get random byte in a range
  tax          // Move value to X
  lda #0       // Zero for high byte (in A)
  jsr LINPRT   // Print the number
  lda #13      // Print a RETURN
  jsr CHROUT
  dec TEMCNT   // Decrement counter
  bne loop     // If not ten values, then loop
  rts

// Initialize SID voice 3 for random numbers.
RDINIT:
  lda #$ff     // Set voice 3 frequency (high byte) to maximum
  sta FREHI3
  lda #%10000000
  sta VCREG3   // Select noise waveform and start release
  sta SIGVOL   // Turn off volume and disconnect output of voice 3
  rts

// Returns a random byte in a range.
RDBYRG:
  lda RANDOM   // Get single byte random number
  cmp LOWLIM   // Lower limit of range
  bcc RDBYRG
  cmp UPPLIM   // Upper limit of range
  bcs RDBYRG
  rts

TEMCNT: .byte 0  // Temporary storage for counter
LOWLIM: .byte 30 // Lowest possible number
UPPLIM: .byte 46 // Highest possible number + 1
