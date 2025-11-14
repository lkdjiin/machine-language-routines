BasicUpstart2(start)

// Machine Language Routines for the commode 64/128
//
// POKSCR page 404
//
// Store screen codes to memory with color.

.const OFFSET = 54272 // Offset to color RAM
.const SCREEN = 1104  // Starting screen position where characters are stored
.const ZP = 251

start:
POKSCR:
  lda #<SCREEN // Low byte of screen position
  ldx #>SCREEN // and high byte
  jsr LOCATE   // Put screen position, text and color RAM, in zero page
               // Now place characters in screen memory in color
  ldy #0       // as an index
POKELP:
  lda COLVAL,y
  sta (ZP+2),y // Store the color for character in SCODE plus Y
  lda SCODE,y
  sta (ZP),y   // Store each screen code
  iny          // Next screen code
  cpy #6       // Have we done all six?
  bne POKELP   // If not, continue
  rts

// Enter with low (A) and high (X) bytes of screen position.
// Store starting text position in ZP and ZP+1, color in ZP+2 and ZP+3.
LOCATE:
  sta ZP // Store screen first position
  stx ZP+1
  // Add in offset for color memory
  clc
  adc #<OFFSET // Low byte first
  sta ZP+2
  txa
  adc #>OFFSET // Then high byte
  sta ZP+3
  rts

SCODE: .byte 12, 9, 14, 5, 32, 51 // Screen codes for "LINE 3"
COLVAL: .byte 5, 2, 7, 4, 4, 14   // Colors — GRN,RED,YEL,PUR,PUR,LTBLU
