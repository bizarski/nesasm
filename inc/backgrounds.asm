
LoadSong1Background: 
  JSR LoadNametableTop
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(track1title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track1title)
  STA pointerHi       ; put the high byte of the address into pointer
  LDY #$00
  LDX #$00
LoadNametableTitle1Loop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$20
  BNE LoadNametableTitle1Loop 
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
  JSR LoadNametableSongTop
  JSR LoadNametableBottom
  RTS 
  
LoadSong4Background: 
  JSR LoadNametableHUD
  LDA #low(track4body)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track4body)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadNametableSongBody
  JSR LoadNametableMostBottom
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
  STA pointerLo2        
  LDA #HIGH(bgtop)
  STA pointerHi2   
  LDY #$00
  LDX #$00
LoadNameTableTopLoop:
  LDA [pointerLo2], y				
  STA $2007							
  INY
  CPY #$B0
  BNE LoadNameTableTopLoop 
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
  STA pointerLo2        
  LDA #HIGH(bgtop)
  STA pointerHi2   
  LDY #$00
  LDX #$00
LoadNametableHUDLoop:
  LDA [pointerLo2], y				
  STA $2007							
  INY
  CPY #$50
  BNE LoadNametableHUDLoop 
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

LoadNametableSongTop:
  LDY #$00
  LDX #$00
LoadNametableSongTopLoop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$A0
  BNE LoadNametableSongTopLoop 
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
  CPX #$02
  BNE LoadNametableSongBodyLoop	
  JSR LoadNametableTitle ; gonna count to 4 which is exactly how many more rows we need 
  RTS

LoadNametableMostBottom:
  LDY #$00
  LDX #$00
  LDA #low(bgmostbottom)
  STA pointerLo
  LDA #HIGH(bgmostbottom)
  STA pointerHi
LoadNametableMostBottomLoop:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  CPY #$FF
  BNE LoadNametableMostBottomLoop  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
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
LoadNametableBottomLoop:
  LDA [pointerLo], Y					
  STA $2007							
  INY
  CPY #$FF
  BNE LoadNametableBottomLoop  
  LDA [pointerLo], Y					
  STA $2007							
  INY								
  INX								
  INC pointerHi						
  CPX #$03
  BNE LoadNametableBottomLoop	
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