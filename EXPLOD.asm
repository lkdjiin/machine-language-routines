BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// EXPLOD page 226
//
// Produce an explosion sound

.const SIGVOL = 54296  // SID chip volume register
.const ATDCY1 = 54277  // voice 1 attack/decay register
.const SUREL1 = 54278  // voice 1 sustain/release register
.const FRELO1 = 54272  // voice 1 frequency control (low byte)
.const FREHI1 = 54273  // voice 1 frequency control (high byte)
.const VCREG1 = 54276  // voice 1 control register
.const JIFFLO = 162    // low byte of jiffy clock

start:
EXPLOD:
  jsr SIDCLR // Clear the SID chip
  lda #15     // Set the volume
  sta SIGVOL
  lda #$0c   // Set attack/decay
  sta ATDCY1
  lda #$18   // Set sustain/release
  sta SUREL1
  lda #0     // Set voice 1 low frequency
  sta FRELO1
  lda #24    // Set voice 1 high frequency
  sta FREHI1
  lda #%10000001 // Select noise waveform and gate sound
  sta VCREG1
  lda #120       // Cause a delay of 120 jiffies
  adc JIFFLO     // Add current jiffy reading
DELAY:
  cmp JIFFLO     // and wait for 120 jiffies to elapse
  bne DELAY
  lda #%10000000 // Ungate sound
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
