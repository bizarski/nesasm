
LoadSong1Background: 
  JSR LoadNametableTop
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(track1title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track1title)
  STA pointerHi       ; put the high byte of the address into pointer
  
  LDA #$20
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadNametableBottom
  RTS 
 
LoadSong2Background: 
  LDA #low(track2bgfull)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track2bgfull)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 
 
LoadSong3Background: 
  JSR LoadNametableHUD
  LDA #low(track3title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track3title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$A0
  STA tmp
  JSR LoadXRowsNametable
  JSR LoadNametableBottom
  RTS 
  
LoadSong4Background: 
  JSR LoadNametableHUD
  LDA #low(track4body)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track4body)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableSongBody
  RTS 

LoadSong5Background: 
  JSR LoadNametableHUD
  LDA #low(track5title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track5title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$A0
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadBlackLine
  JSR LoadBlackLine
  LDY #$00
  LDX #$00
  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$00	; FF + 1
  STA tmp
  JSR LoadXRowsNametable
  
  INC pointerHi						
 
  LDA #$C0
  STA tmp
  
  JSR LoadXRowsNametable
  
  LDA #low(track5bottom)
  STA pointerLo
  LDA #HIGH(track5bottom)
  STA pointerHi
  
  LDA #$00	; FF + 1
  STA tmp
  JSR LoadXRowsNametable
  
  RTS 

LoadSong6Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(track6title)
  STA pointerLo    
  LDA #HIGH(track6title)
  STA pointerHi
  
  LDA #$00
  STA tmp
  JSR LoadXRowsNametable
  INC pointerHi  
  LDA #$10
  STA tmp
  JSR LoadXRowsNametable
  
  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$00
  STA tmp 
  JSR LoadXRowsNametable
  INC pointerHi
  JSR LoadXRowsNametable
  INC pointerHi
  LDA #$80
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(track6attributes)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track6attributes)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable
  
  RTS 

LoadSong7Background: 
  JSR LoadNametableHUD
  LDA #low(track7title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track7title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$A0
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine

  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$00
  STA tmp 
  JSR LoadXRowsNametable
  INC pointerHi
  LDA #$80
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(track7bottom)
  STA pointerLo
  LDA #HIGH(track7bottom)
  STA pointerHi
  
  LDA #$00
  STA tmp
  JSR LoadXRowsNametable
  INC pointerHi

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  RTS 

LoadSong8Background: 
  JSR LoadNametableTop
  LDA #low(track8title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track8title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 
  
LoadSong9Background: 
  JSR LoadNametableTop
  LDA #low(track9title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track9title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 
  
LoadSong10Background: 
  JSR LoadNametableTop
  LDA #low(track10title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track10title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 
  
LoadSong11Background: 
  JSR LoadNametableTop
  LDA #low(track11title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track11title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 
  
LoadSong12Background: 
  JSR LoadNametableTop
  LDA #low(track12title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track12title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 
  
LoadSong13Background: 
  JSR LoadNametableTop
  LDA #low(track13title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track13title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable

  JSR LoadNametableBottom
  RTS 

LoadBlackLine: 
  LDX #$00
  LDA #$24
LoadBlackLineLoop
  STA $2007		
  INX
  CPX #$10
  BNE LoadBlackLineLoop
  RTS 

LoadNametableTop:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(bgtop)
  STA pointerLo        
  LDA #HIGH(bgtop)
  STA pointerHi 
  LDA #$B0
  STA tmp
  JSR LoadXRowsNametable 
  RTS
  
LoadNametableHUD:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(bgtop)
  STA pointerLo    
  LDA #HIGH(bgtop)
  STA pointerHi
  LDY #$00
  LDX #$00
LoadNametableHUDLoop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$50
  BNE LoadNametableHUDLoop 
  RTS

LoadXRowsNametable:
  LDY #$00
LoadXRowsNametableLoop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY tmp
  BNE LoadXRowsNametableLoop 
  RTS

LoadNametableSongBody:
  LDY #$00
  LDX #$00
LoadNametableSongBodyLoop:
  LDA [pointerLo], Y					
  STA $2007							
  INY  
  CPY #$FF
  BNE LoadNametableSongBodyLoop  
  LDA [pointerLo], Y					
  STA $2007						
  INY								
  INX								
  INC pointerHi						
  CPX #$04
  BNE LoadNametableSongBodyLoop	
  RTS

LoadNametableBottom:
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDY #$00
  LDX #$00
  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$00
  STA tmp 
  JSR LoadXRowsNametable
  INC pointerHi
  JSR LoadXRowsNametable
  INC pointerHi
  LDA #$BA
  STA tmp 
  JSR LoadXRowsNametable

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
  
LoadPalette6: 
  LDA #low(palette6)
  STA pointerLo       
  LDA #HIGH(palette6)
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