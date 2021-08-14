
LoadSong1Background: 
  JSR LoadNametableHUD
  LDA #low(track1title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track1title)
  STA pointerHi       ; put the high byte of the address into pointer
  
  LDA #$60
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine
   
  LDA #$80
  STA tmp
  JSR LoadXRowsNametableLoop

  JSR LoadNametableBottom
  RTS 
 
LoadSong2Background: 
  JSR LoadNametableHUD
  
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine

  LDA #low(track2title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track2title)
  STA pointerHi       ; put the high byte of the address into pointer
  
  LDA #$60
  STA tmp 
  JSR LoadXRowsNametable
 
  JSR LoadBlackLine
  JSR LoadBlackLine
 
  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$00	; FF + 1
  STA tmp
  JSR LoadXRowsNametable
  INC pointerHi			
  
  LDA #$C0	; FF + 1
  STA tmp  
  JSR LoadXRowsNametable

  LDA #low(track2bottom)
  STA pointerLo
  LDA #HIGH(track2bottom)
  STA pointerHi
  
  LDA #$00	; FF + 1
  STA tmp  
  JSR LoadXRowsNametable
  
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
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  JSR LoadBottomWithoutAttributes
  
  LDA #low(track3attributes)
  STA pointerLo
  LDA #HIGH(track3attributes)
  STA pointerHi
  
  LDA #$40 
  STA tmp 
  JSR LoadXRowsNametable
  
  RTS 
  
LoadSong4Background: 
  JSR LoadNametableHUD
  LDA #low(track4body)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track4body)
  STA pointerHi       ; put the high byte of the address into pointer
  
  LDA #$00 
  STA tmp 
  JSR LoadXRowsNametable
  INC pointerHi
  JSR LoadXRowsNametable
  INC pointerHi
  JSR LoadXRowsNametable
  INC pointerHi
  
  LDA #$20 
  STA tmp 
  JSR LoadXRowsNametable
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$60 
  STA tmp 
  JSR LoadXRowsNametableLoop

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
  
  LDA #$A0	
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$E0	
  STA tmp
  JSR LoadXRowsNametableLoop
  
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
  
  JSR LoadBottomWithoutAttributes
  
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
  JSR LoadNametableHUD

  JSR LoadBlackLine

  LDA #low(track8bg)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track8bg)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$10
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$70
  STA tmp
  JSR LoadXRowsNametableLoop

  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$A0
  STA tmp
  JSR LoadXRowsNametableLoop
  
  JSR LoadBlackLine
  
  LDA #$D0
  STA tmp
  JSR LoadXRowsNametableLoop
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$00
  STA tmp
  JSR LoadXRowsNametableLoop
  
  INC pointerHi
  
  LDA #$40
  STA tmp
  JSR LoadXRowsNametableLoop
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  
  LDA #$60
  STA tmp
  JSR LoadXRowsNametableLoop
  
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine

  LDA #$00
  STA tmp
  JSR LoadXRowsNametableLoop
  
  INC pointerHi
  
  LDA #$40
  STA tmp
  JSR LoadXRowsNametableLoop

  RTS 
  
LoadSong9Background: 
  JSR LoadNametableHUD

  LDA #low(track9title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track9title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$A0
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine

  JSR LoadBottomWithoutAttributes
  
  LDA #low(track9attributes)
  STA pointerLo       
  LDA #HIGH(track9attributes)
  STA pointerHi       

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable
  
  RTS 
  
LoadSong10Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  JSR LoadBlackLine
  JSR LoadBlackLine
  JSR LoadBlackLine
  LDA #low(track10hud)
  STA pointerLo    
  LDA #HIGH(track10hud)
  STA pointerHi
  LDA #$30
  STA tmp
  JSR LoadXRowsNametable 
  JSR LoadBlackLine
  LDA #$40
  STA tmp
  JSR LoadXRowsNametableLoop 
  
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine
  JSR LoadBlueLine
  
  LDA #low(track10title)
  STA pointerLo    
  LDA #HIGH(track10title)
  STA pointerHi
  
  LDA #$40
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine

  JSR LoadBottomWithoutAttributes
  
  LDA #low(track10attributes)
  STA pointerLo       
  LDA #HIGH(track10attributes)
  STA pointerHi       
  
  LDA #$40
  STA tmp
  JSR LoadXRowsNametable
  
  RTS 
  
LoadSong11Background: 
  JSR LoadNametableHUD
  LDA #low(track11title)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(track11title)
  STA pointerHi       ; put the high byte of the address into pointer

  LDA #$40
  STA tmp
  JSR LoadXRowsNametable
  
  JSR LoadBlueLine
  JSR LoadBlueLine
  
  LDA #$80
  STA tmp
  JSR LoadXRowsNametableLoop

  JSR LoadBlackLine
  JSR LoadBlackLine

  LDA #low(bgbottom)
  STA pointerLo
  LDA #HIGH(bgbottom)
  STA pointerHi
  
  LDA #$A0
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(track11body1)
  STA pointerLo
  LDA #HIGH(track11body1)
  STA pointerHi
  
  LDA #$20
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(bgbottom2)
  STA pointerLo
  LDA #HIGH(bgbottom2)
  STA pointerHi

  LDA #$40
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(track11body2)
  STA pointerLo
  LDA #HIGH(track11body2)
  STA pointerHi
  
  LDA #$40
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(bgbottom3)
  STA pointerLo
  LDA #HIGH(bgbottom3)
  STA pointerHi

  LDA #$20
  STA tmp 
  JSR LoadXRowsNametable
  
  LDA #low(track11body3)
  STA pointerLo
  LDA #HIGH(track11body3)
  STA pointerHi
  
  LDA #$20
  STA tmp 
  JSR LoadXRowsNametable

  LDA #low(bgmostbottom)
  STA pointerLo
  LDA #HIGH(bgmostbottom)
  STA pointerHi

  LDA #$E0
  STA tmp 
  JSR LoadXRowsNametable
 
  JSR LoadBlackLine
  JSR LoadBlackLine  
  
  LDA #low(track11attributes)
  STA pointerLo
  LDA #HIGH(track11attributes)
  STA pointerHi

  LDA #$40
  STA tmp 
  JSR LoadXRowsNametable

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

LoadBlueLine: 
  LDX #$00
  LDA #$27
LoadBlueLineLoop
  STA $2007		
  INX
  CPX #$10
  BNE LoadBlueLineLoop
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
  LDA #$30
  STA tmp
  JSR LoadXRowsNametable 
  JSR LoadBlackLine
  LDA #$A0
  STA tmp
  JSR LoadXRowsNametableLoop 
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
  LDA #$30
  STA tmp
  JSR LoadXRowsNametable 
  JSR LoadBlackLine
  LDA #$40
  STA tmp
  JSR LoadXRowsNametableLoop 
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
  

LoadNametableBottom:
  JSR LoadBlackLine
  JSR LoadBlackLine

  JSR LoadBottomWithoutAttributes
  
  LDA #$40 
  STA tmp 
  JSR LoadXRowsNametableLoop

  RTS


LoadBottomWithoutAttributes: 
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
  LDA #$60
  STA tmp 
  JSR LoadXRowsNametable
  
  JSR LoadBlackLine
  JSR LoadBlackLine
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
  LDA #low(bgpalette)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(bgpalette)
  STA pointerHi       ; put the high byte of the address into pointer
  JSR LoadPaletteRoutine
  RTS 

LoadPalette2: 
  LDA #low(bgpalette2)
  STA pointerLo       
  LDA #HIGH(bgpalette2)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPalette4: 
  LDA #low(bgpalette4)
  STA pointerLo       
  LDA #HIGH(bgpalette4)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 

LoadPalette5: 
  LDA #low(bgpalette5)
  STA pointerLo       
  LDA #HIGH(bgpalette5)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 
  
LoadPalette6: 
  LDA #low(bgpalette6)
  STA pointerLo       
  LDA #HIGH(bgpalette6)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 
  
LoadPalette9: 
  LDA #low(bgpalette9)
  STA pointerLo       
  LDA #HIGH(bgpalette9)
  STA pointerHi      
  JSR LoadPaletteRoutine
  RTS 
  
LoadPalette11: 
  LDA #low(bgpalette11)
  STA pointerLo       
  LDA #HIGH(bgpalette11)
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
  CPY #$10
  BNE LoadPalettesLoop 
  
  LDA #low(spritepalette)
  STA pointerLo       
  LDA #HIGH(spritepalette)
  STA pointerHi    
  
  LDY #$00 
  
LoadPalettes2Loop:
  LDA [pointerLo], y				
  STA $2007							
  INY
  CPY #$10
  BNE LoadPalettes2Loop 
  
  RTS  