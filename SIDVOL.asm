BasicUpstart2(start)
// (Memory management)
// FILMEM p237 General memory fill
// (Multiplication)
// MULSHF p363 Multiply two unsigned integer values using bit shifts
// (Printing numbers)
// BYTASC p131 Print a one-byte integer value
// CNUMOT p181 Print a two-byte integer value
// (Sound and music)
// INTMUS p287 Interrupt-driven music
// MELODY p339 Tune player
// SIDVOL p470 Set the SID chip volume register
// SIRENS p471 Produce a siren sound

// Machine Language Routines for the commode 64/128
//
// SIDVOL page 470
//
// Set the SID chip volume register

.const SIGVOL = 54296 // Volume and filter-select register

// Set the volume to 15.
start:
  lda #15 // Load A with the volume, 0 (minimum) throught 15 (maximum)
  jmp SIDVOL // Set the volume to A

// Enter with the volume in A.
SIDVOL:
  sta SIGVOL // Store the volume value in A into the volume register
  rts
