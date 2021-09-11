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
  LDA (SPRATZ_RAM+3), y
  SEC
  SBC #$08
  STA (SPRATZ_RAM+3), y
  
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ ContinueMove2
  JMP ContinueMove 
  
ShiftSpriteRight: 
  LDA (SPRATZ_RAM+3), y
  CLC
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
  JMP DpadReactDone


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
  JMP DpadReactDone
  
  
SetHitFlag: 
  LDA gameFlags
  ORA #HERO_HIT
  STA gameFlags
  RTS

CheckHitSpriteFlipped:
  SEC
  SBC #$08
  CMP tmp 
  BCS SpritesNoHit
  CLC
  ADC #$18
  CMP tmp 
  BCC SpritesNoHit
  JSR SetHitFlag
SpritesNoHit: 
  RTS 
  
CheckHitSprite:  
  CLC
  ADC #$08
  CMP tmp 
  BCC SpritesNoHit2
  SEC
  SBC #$18
  CMP tmp 
  BCS SpritesNoHit2
  JSR SetHitFlag
SpritesNoHit2: 
  RTS 
 
CheckHitHero: 
  LDA (SPRATZ_RAM+3)
  JSR CheckHitSprite
  RTS

CheckHitHeroFlipped: 
  LDA (SPRATZ_RAM+3)
  JSR CheckHitSpriteFlipped
  RTS

SpratzCheckHit: 
  LDA (BLUEPILL_RAM+4)    ; bottom part of pill 
  CMP #SPRITE_SPR_Y
  BCC SpratzNoHit
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS SpratzNoHit
  LDA (BLUEPILL_RAM+3+4)
  STA tmp 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ bl_CheckHitHeroFlipped 
  BNE bl_CheckHitHero
SpratzNoHit: 
  JMP SpratzCheckHitDone 

bl_CheckHitHeroFlipped: 
  JSR CheckHitHeroFlipped
  JMP SpratzCheckHitDone

bl_CheckHitHero: 
  JSR CheckHitHero
  JMP SpratzCheckHitDone

SpratzCheckBonus: 
  LDA (REDPILL_RAM+4)    ; bottom part of pill 
  CMP #SPRITE_SPR_Y
  BCC SpratzNoBonus
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS SpratzNoBonus
  LDA (REDPILL_RAM+3+4)
  STA tmp 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ bo_CheckHitHeroFlipped 
  BNE bo_CheckHitHero
  
HidePill:
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ SpratzNoBonus
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
SpratzNoBonus: 
  JMP SpratzCheckBonusDone

;;;;;;;;;;;;

bo_CheckHitHeroFlipped:
  JSR CheckHitHeroFlipped
  JMP HidePill
;;;;;;;;;
  
bo_CheckHitHero:
  JSR CheckHitHero
  JMP HidePill
;;;;;;;;;
  
SpratzCheckBonus2: 
  LDA (COIN_RAM)    ; bottom part of pill 
  CMP #SPRITE_SPR_Y
  BCC NoBonus2
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS NoBonus2
  LDA (COIN_RAM+3)
  STA tmp 
  LDA #%01000000
  BIT (SPRATZ_RAM+2)
  BEQ c_CheckHitHero 
  BNE c_CheckHitHeroFlipped
HideCoin:
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ NoBonus2
  LDA #$F0
  STA (COIN_RAM+0)
NoBonus2: 
  JMP SpratzCheckBonus2Done

c_CheckHitHero:
  JSR CheckHitHeroFlipped
  JMP HideCoin
;;;;;;;;;;;
c_CheckHitHeroFlipped:
  JSR CheckHitHero
  JMP HideCoin
;;;;;;;;;;;
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

  INC playerScore+1 		; increase score by 1
  LDA playerScore+1
  CMP #$00					; check if LSB has wrapped to 0
  BNE IncrementPlayerScoreDone
  INC playerScore+0			; if so, increment MSB
IncrementPlayerScoreDone: 

  RTS
  

SayWoo: 
  LDA #$0D
  STA WOO_RAM
  STA WOO_RAM+4
  STA WOO_RAM+4*2
  STA WOO_RAM+4*3
  JSR IncrementScoreDisplay
  RTS 

PlaySampleA: 
  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE DontPlaySampleA
  
  LDA WOO_RAM
  CMP #$F0 
  BNE DontSayWoo
  
  LDA PAUSE_RAM 
  CMP #$FF
  BEQ DontSayWoo 
  
  LDA NOISE_RAM
  CMP #$13
  BCS DontSayWoo

  JSR SayWoo
	
DontSayWoo: 

  LDA samplePointer
  JSR PlaySample
DontPlaySampleA: 
  RTS

PlaySampleB:
  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE DontPlaySampleB

  LDA WOO_RAM
  CMP #$F0 
  BNE DontSayWoo2
  
  LDA PAUSE_RAM 
  CMP #$FF
  BEQ DontSayWoo2 
  
  LDA NOISE_RAM
  CMP #$13
  BCC DontSayWoo2
  CMP #$19
  BCS DontSayWoo2
  JSR SayWoo
DontSayWoo2:
  LDA samplePointer
  CLC
  ADC #$01
  JSR PlaySample
DontPlaySampleB: 
  RTS


ChangeSamples: 
  LDA #SAMPLE_CHANGED
  BIT soundFlags
  BNE SkipUpdateSample  
UpdateInventory: 
  LDA (INVENTORY_RAM+1)
  CLC
  ADC #$10 
  CMP #$4E
  BNE StoreInventoryChange
  LDA #$0E
StoreInventoryChange: 
  STA (INVENTORY_RAM+1)
UpdateSamplePointer:
  LDA samplePointer
  CLC 
  ADC #$02
  CMP #$08
  BNE StoreSamplePointer
  LDA #$00
StoreSamplePointer:
  STA samplePointer  
  LDA soundFlags
  EOR #SAMPLE_CHANGED
  STA soundFlags

SkipUpdateSample: 
  JMP DpadReactDone


SpritesBop: 
  LDA currentHeroBop
  STA (SPRATZ_RAM+1+4*3)
  LDA #$29
  STA (SPRATZ_RAM+1+4*5)

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE DontPlayHey

  LDA NOISE_RAM
  CMP #$13
  BCC DontSayWoo3
  CMP #$19
  BCS DontSayWoo3
  JSR SayWoo

DontSayWoo3:
  LDA #$0A
  JSR PlaySample
DontPlayHey: 
  JMP ActionsReactDone