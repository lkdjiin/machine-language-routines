BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BEEPER page 115
//
// Emit a bell sound

.const SIGVOL = 54296  // SID chip volume register
.const ATDCY1 = 54277  // voice 1 attack/decay register
.const SUREL1 = 54278  // voice 1 sustain/release register
.const FRELO1 = 54272  // voice 1 frequency control (low byte)
.const FREHI1 = 54273  // voice 1 frequency control (high byte)
.const FREHI3 = 54287  // voice 3 frequency control (high byte)
.const VCREG1 = 54276  // voice 1 control register

start:
BELLRG:
  jsr SIDCLR // Clear the SID chip
  lda #7     // Set the volume
  sta SIGVOL
  lda #$0a   // Set attack/decay
  sta ATDCY1
  sta SUREL1
  lda #67    // Set voice 1 high frequency
  sta FREHI1
  sta FREHI3 // For ring modulation
  lda #%00010101 // Select triangle waveform/ring modulation/gate sound
  sta VCREG1
  lda #%00010000 // Ungate sound
  sta VCREG1
  rts

// Clear the SID chip.
SIDCLR:
  lda #0  // Fill with zeros
  ldy #24 // Index to FRELO1
SIDLOP:
  sta FRELO1,y // Store in SID chip address
  dey          // For next lower byte
  bpl SIDLOP   // Fill 25 bytes
  rts
