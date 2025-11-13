BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// RNDBYT page 445
//
// Generate a random byte value from SID chip voice 3.
// Put a random color anywhere in first 256 bytes of screen.
// Quit when any key is pressed.

.const GETIN = 65508
.const COLRAM = 55296 // Start of screen color memory
.const FREHI3 = 54287 // Voice 3 frequency control register (high byte)
.const VCREG3 = 54290 // Voice 3 control register
.const SIGVOL = 54296 // Volume and filter select register
.const RANDOM = 54299 // Oscillator 3/random number generator

start:
  jsr RDINIT   // Initialize SID voice 3 for random numbers
loop:
  jsr RNDBYT   // Get a random byte for screen offset
  tay          // Store offset in Y
  jsr RNDBYT   // Get random number for color byte
  sta COLRAM,Y // Store color byte randomly in first quarter
  jsr GETIN    // Check for a keypress
  beq loop     // No keypress, so continue
  rts          // Else quit

// Routine to initialize SID voice 3 for random numbers.
RDINIT:
  lda #$ff     // Set voice 3 frequency (high byte) to maximum
  sta FREHI3
  lda #%10000000
  sta VCREG3   // Select noise waveform and start release for voice 3
  sta SIGVOL   // Turn off volume and disconnect output of voice 3
  rts

// RNDBYT returns a random byte value in A.
RNDBYT:
  lda RANDOM   // Get single byte random number
  rts
