
LoadSong1Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song1_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song1_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 
 
LoadSong2Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song2_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song2_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 

LoadSong4Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song4_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song4_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 

LoadSong5Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song5_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song5_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 

LoadNametable:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  CPY #$FF
  BNE LoadNametable  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
  LDA [pointerLo], Y					; since the loop ends before Y=$FF is used, run one more time to get to 256 bytes.
  STA $2007							; write to PPU
  INY								; increment Y to overflow back to $00 and prepare for next round
  INX								; increment X now that the first of four blocks of 256 bytes is done
  INC pointerHi						; move offset to next 256-byte block of memory
  CPX #$04
  BNE LoadNametable	; when X=$04, 4 rounds of 256 are complete for a full 1024 bytes read.
  RTS
