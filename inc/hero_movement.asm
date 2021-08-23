SpratzDirLeft: 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BNE DontUpdateFlag
  LDY #$00
  LDX #$00
FlipLoopLeft:
  LDA (SPRATZ_RAM+2), y
  ORA #%01000000
  STA (SPRATZ_RAM+2), y
  CLC 
  TXA 
  LSR A 
  BCC ShiftSpriteRight ; even
  BCS ShiftSpriteLeft  ; odd
ContinueMove: 
  INX
  INY 
  INY 
  INY 
  INY 
  CPY #$20 
  BNE FlipLoopLeft
DontUpdateFlag:
  RTS 

SpratzDirRight: 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ DontUpdateFlag2
  LDY #$00
  LDX #$00
FlipLoopRight:
  LDA (SPRATZ_RAM+2), y
  AND #%10111111
  STA (SPRATZ_RAM+2), y
  CLC 
  TXA 
  LSR A 
  BCC ShiftSpriteLeft
  BCS ShiftSpriteRight
ContinueMove2: 
  INX 
  INY 
  INY 
  INY 
  INY 
  CPY #$20 
  BNE FlipLoopRight
DontUpdateFlag2:
  RTS 

ShiftSpriteLeft: 
  SEC
  LDA (SPRATZ_RAM+3), y
  SBC #$08
  STA (SPRATZ_RAM+3), y
  
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ ContinueMove2
  JMP ContinueMove 
  
ShiftSpriteRight: 
  CLC
  LDA (SPRATZ_RAM+3), y
  ADC #$08
  STA (SPRATZ_RAM+3), y

  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ ContinueMove2
  JMP ContinueMove 

SpratzMoveLeft:
  JSR SpratzDirLeft
  LDA (SPRATZ_RAM+3)
  CMP #OPAQUE_X_LEFT
  BEQ SpratzDontMoveLeft
  JSR AnimateWalk
  LDX #LOW(SPRATZ_RAM)
SpratzMoveLeftLoop: 
  LDA ($0400+3), x
  SEC            
  SBC #$01       
  STA ($0400+3), x
  INX
  INX
  INX  
  INX
  CPX #LOW(SPRATZ_RAM)+32
  BNE SpratzMoveLeftLoop
SpratzDontMoveLeft:
  RTS


SpratzMoveRight:
  JSR SpratzDirRight
  LDA (SPRATZ_RAM+4+3)
  CMP #OPAQUE_X_RIGHT
  BEQ SpratzDontMoveRight
  JSR AnimateWalk
  LDX #LOW(SPRATZ_RAM)
SpratzMoveRightLoop: 
  LDA ($0400+3), x
  CLC            
  ADC #$01       
  STA ($0400+3), x
  INX
  INX
  INX
  INX
  CPX #LOW(SPRATZ_RAM)+32
  BNE SpratzMoveRightLoop
SpratzDontMoveRight:
  RTS
  
  
SetHitFlag: 
  LDA gameFlags
  ORA #HERO_HIT
  STA gameFlags
  RTS 

CheckHitSprite: 
  SEC 
  CMP tmp 
  BCS SpritesNoHit
  ADC #$08
  CMP tmp 
  BCC SpritesNoHit
  JSR SetHitFlag
SpritesNoHit: 
  RTS 
  
SpratzCheckHit: 
  LDA (BLUEPILL_RAM+4)    ; bottom part of pill 
  SEC
  CMP #SPRITE_SPR_Y
  BCC NoHit
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS NoHit
  LDA (BLUEPILL_RAM+3+4)
  STA tmp 
  LDX #$00
CheckHitLoop: 
  LDA (SPRATZ_RAM+3), x
  JSR CheckHitSprite
  INX
  INX
  INX
  INX
  CPX #$10
  BNE CheckHitLoop
NoHit: 
  RTS
