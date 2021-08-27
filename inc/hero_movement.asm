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

CheckHitSpriteFlipped:
  SEC 
  CLC 
  SBC #$08
  CMP tmp 
  BCS SpritesNoHit
  ADC #$18
  CMP tmp 
  BCC SpritesNoHit
  JSR SetHitFlag
SpritesNoHit: 
  RTS 
  
CheckHitSprite: 
  SEC 
  CLC
  ADC #$08
  CMP tmp 
  BCC SpritesNoHit2
  SBC #$18
  CMP tmp 
  BCS SpritesNoHit2
  JSR SetHitFlag
SpritesNoHit2: 
  RTS 
 
CheckHitHeroFlipped: 
  LDA (SPRATZ_RAM+3)
  JSR CheckHitSprite
  RTS

CheckHitHero: 
  LDA (SPRATZ_RAM+3)
  JSR CheckHitSpriteFlipped
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
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ CheckHitHero 
  BNE CheckHitHeroFlipped
NoHit: 
  RTS 

SpratzCheckBonus: 
  LDA (REDPILL_RAM+4)    ; bottom part of pill 
  SEC
  CMP #SPRITE_SPR_Y
  BCC NoBonus
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS NoBonus
  LDA (REDPILL_RAM+3+4)
  STA tmp 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ b_CheckHitHero 
  BNE b_CheckHitHeroFlipped
HidePill:
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ NoBonus
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
NoBonus: 
  RTS

b_CheckHitHero:
  JSR CheckHitHero
  JMP HidePill
  RTS
  
b_CheckHitHeroFlipped:
  JSR CheckHitHeroFlipped
  JMP HidePill
  RTS

IncrementScoreDisplay:
  INC (SCORE_RAM+4*2+1)		; increment 3rd digit tile number
  LDA (SCORE_RAM+4*2+1)
  CMP #($C9+$01)							; check if 3rd digit went past 9
  BNE IncrementScoreDisplayDone			; if not, we're done
  
  LDA #$C0
  STA (SCORE_RAM+4*2+1)		; if so, reset 3rd digit to 0...
  INC (SCORE_RAM+4+1)		; and increment 2nd digit tile number
  LDA (SCORE_RAM+4+1)
  CMP #($C9+$01)							; check if 2nd digit went past 9
  BNE IncrementScoreDisplayDone			; if not, we're done
  
  LDA #$C0
  STA (SCORE_RAM+4+1)		; if so, reset 2nd digit to 0...
  INC (SCORE_RAM+1)		; and increment 1st digit tile number
  LDA (SCORE_RAM+1)
  CMP #($C9+$01)							; check if 1st digit went past 9
  BNE IncrementScoreDisplayDone			; if not, we're done
  
  LDA #$C0								; if so (unlikely), reset all digits to 0, reset playerscore, and store 999 in highscore
  STA (SCORE_RAM+4*2+1)
  STA (SCORE_RAM+4+1)
  STA (SCORE_RAM+1)

IncrementScoreDisplayDone: 
  RTS