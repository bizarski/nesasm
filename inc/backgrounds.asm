
LoadSong1Background: 
  JSR LoadNametableTop
  LDA #low(track1title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track1title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
 
LoadSong2Background: 
  JSR LoadNametableTop
  LDA #low(track2title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track2title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
 
LoadSong3Background: 
  JSR LoadNametableTop
  LDA #low(track3title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track3title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong4Background: 
  JSR LoadNametableTop
  LDA #low(track4title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track4title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 

LoadSong5Background: 
  JSR LoadNametableTop
  LDA #low(track5title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track5title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 

LoadSong6Background: 
  JSR LoadNametableTop
  LDA #low(track6title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track6title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 

LoadSong7Background: 
  JSR LoadNametableTop
  LDA #low(track7title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track7title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 

LoadSong8Background: 
  JSR LoadNametableTop
  LDA #low(track8title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track8title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong9Background: 
  JSR LoadNametableTop
  LDA #low(track9title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track9title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong10Background: 
  JSR LoadNametableTop
  LDA #low(track10title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track10title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong11Background: 
  JSR LoadNametableTop
  LDA #low(track11title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track11title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong12Background: 
  JSR LoadNametableTop
  LDA #low(track12title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track12title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 
  
LoadSong13Background: 
  JSR LoadNametableTop
  LDA #low(track13title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track13title)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableTitle
  JSR LoadNametableBottom
  RTS 

LoadNametableTop:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  LDA #low(bgtop)
  STA pointerLo2        
  LDA #HIGH(bgtop)
  STA pointerHi2   
  LDY #$00
  LDX #$00
LoadNameTableTopLoop:
  LDA [pointerLo2], y				
  STA $2007							
  INY
  CPY #$E0
  BNE LoadNameTableTopLoop 
  RTS
	
LoadNametableTitle:
  LDY #$00
  LDX #$00
LoadNametableTitleLoop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$40
  BNE LoadNametableTitleLoop 
  RTS

LoadNametableBottom:
  LDY #$00
  LDX #$00
  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
LoadNametableBottomLoop:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  CPY #$FF
  BNE LoadNametableBottomLoop  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
  LDA [pointerLo], Y					; since the loop ends before Y=$FF is used, run one more time to get to 256 bytes.
  STA $2007							; write to PPU
  INY								; increment Y to overflow back to $00 and prepare for next round
  INX								; increment X now that the first of four blocks of 256 bytes is done
  INC pointerHi						; move offset to next 256-byte block of memory
  CPX #$03
  BNE LoadNametableBottomLoop	; when X=$04, 4 rounds of 256 are complete for a full 1024 bytes read.
  RTS


LoadNametable:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
LoadNameTableLoop:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  CPY #$FF
  BNE LoadNameTableLoop  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
  LDA [pointerLo], Y					; since the loop ends before Y=$FF is used, run one more time to get to 256 bytes.
  STA $2007							; write to PPU
  INY								; increment Y to overflow back to $00 and prepare for next round
  INX								; increment X now that the first of four blocks of 256 bytes is done
  INC pointerHi						; move offset to next 256-byte block of memory
  CPX #$04
  BNE LoadNameTableLoop	; when X=$04, 4 rounds of 256 are complete for a full 1024 bytes read.
  RTS
  

LoadPalette1: 
  LDA #low(palette)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(palette)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadPaletteRoutine
  RTS 

LoadPalette2: 
  LDA #low(palette2)
  STA pointerLo       
  LDA #HIGH(palette2)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPalette3: 
  LDA #low(palette3)
  STA pointerLo       
  LDA #HIGH(palette3)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPalette4: 
  LDA #low(palette4)
  STA pointerLo       
  LDA #HIGH(palette4)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPalette5: 
  LDA #low(palette5)
  STA pointerLo       
  LDA #HIGH(palette5)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPaletteRoutine: 
  LDA $2002             
  LDA #$3F
  STA $2006             
  LDA #$00
  STA $2006             
  LDY #$00             
LoadPalettesLoop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$20
  BNE LoadPalettesLoop 
  RTS  