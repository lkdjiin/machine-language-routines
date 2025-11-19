BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// BEEPER page 113
//
// Emit a beep sound

.const SIGVOL = 54296  // SID chip volume register
.const ATDCY1 = 54277  // voice 1 attack/decay register
.const SUREL1 = 54278  // voice 1 sustain/release register
.const FRELO1 = 54272  // voice 1 frequency control (low byte)
.const FREHI1 = 54273  // voice 1 frequency control (high byte)
.const VCREG1 = 54276  // voice 1 control register
.const JIFFLO = 162    // Low byte of jiffy clock

start:
BEEPER:
  jsr SIDCLR // Clear the SID chip
  lda #15    // Set the volume
  sta SIGVOL
  lda #0     // Set attack/decay
  sta ATDCY1
  lda #$f0   // Set sustain/release
  sta SUREL1
  lda #132   // Set voice 1 frequency (low byte)
  sta FRELO1
  lda #125   // Set voice 1 frequency (high byte)
  sta FREHI1
  lda #%00010001 // Select triangle waveform and gate sound
  sta VCREG1
  lda #2     // Cause a delay of two jiffies
  adc JIFFLO // Add current jiffy reading
DELAY:
  cmp JIFFLO // and wait for two jiffies to elapse
  bne DELAY
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
