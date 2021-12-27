;;;;;;;; hero movement

SpratzDirLeft: 
  LDA #%01000000
  BIT (HERO_RAM+2)
  BNE DontUpdateFlag
  LDY #$00
  LDX #$00
FlipLoopLeft:
  LDA (HERO_RAM+2), y
  ORA #%01000000
  STA (HERO_RAM+2), y
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
  BIT (HERO_RAM+2)
  BEQ DontUpdateFlag2
  LDY #$00
  LDX #$00
FlipLoopRight:
  LDA (HERO_RAM+2), y
  AND #%10111111
  STA (HERO_RAM+2), y
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
  LDA (HERO_RAM+3), y
  SEC
  SBC #$08
  STA (HERO_RAM+3), y
  
  LDA #%01000000
  BIT (HERO_RAM+2)
  BEQ ContinueMove2
  JMP ContinueMove 
  
ShiftSpriteRight: 
  LDA (HERO_RAM+3), y
  CLC
  ADC #$08
  STA (HERO_RAM+3), y

  LDA #%01000000
  BIT (HERO_RAM+2)
  BEQ ContinueMove2
  JMP ContinueMove 

SpratzMoveLeft:
  JSR SpratzDirLeft
  LDA (HERO_RAM+3)
  CMP #OPAQUE_X_LEFT
  BEQ SpratzDontMoveLeft
  JSR AnimateWalk
  LDX #LOW(HERO_RAM)
SpratzMoveLeftLoop: 
  LDA ($0400+3), x
  SEC            
  SBC #$01       
  STA ($0400+3), x
  INX
  INX
  INX  
  INX
  CPX #LOW(HERO_RAM)+32
  BNE SpratzMoveLeftLoop
SpratzDontMoveLeft:
  JMP EnginePlaying_DpadReactDone


SpratzMoveRight:
  JSR SpratzDirRight
  LDA (HERO_RAM+4+3)
  CMP #OPAQUE_X_RIGHT
  BEQ SpratzDontMoveRight
  JSR AnimateWalk
  LDX #LOW(HERO_RAM)
SpratzMoveRightLoop: 
  LDA ($0400+3), x
  CLC            
  ADC #$01       
  STA ($0400+3), x
  INX
  INX
  INX
  INX
  CPX #LOW(HERO_RAM)+32
  BNE SpratzMoveRightLoop
SpratzDontMoveRight:
  JMP EnginePlaying_DpadReactDone
  
;;;;;;;; hero hit common logic 
  
CheckHitHero: 
  LDA (HERO_RAM+3)
  JSR CheckHitSprite
  RTS
  
CheckHitHeroFlipped: 
  LDA (HERO_RAM+3)
  JSR CheckHitSpriteFlipped
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
  
SetHitFlag: 
  LDA gameFlags
  ORA #HERO_HIT
  STA gameFlags
  RTS
  
;;;;;;; hero death hit check 

SpratzCheckHit: 
  LDA (BLUEPILL_RAM+1)
  CMP #$18
  BEQ SpratzNoHit
  LDA (BLUEPILL_RAM+4)    ; bottom part of pill 
  CMP #SPRITE_SPR_Y
  BCC SpratzNoHit
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS SpratzNoHit
  LDA (BLUEPILL_RAM+3+4)
  STA tmp 
  LDA #%01000000
  BIT (HERO_RAM+2)
  BEQ pill_CheckHitHeroFlipped 
  BNE pill_CheckHitHero
SpratzNoHit: 
  JMP EnginePlaying_SpratzCheckHitDone 

pill_CheckHitHeroFlipped: 
  JSR CheckHitHeroFlipped
  JMP EnginePlaying_SpratzCheckHitDone

pill_CheckHitHero: 
  JSR CheckHitHero
  JMP EnginePlaying_SpratzCheckHitDone

PlayerHit: 
  JSR DecrementLivesDisplay
  LDA playerLives 
  CMP #$FF   
  BNE SkipGameOver

  LDX currentHero
  LDA heroDeathSprites, x
  STA (HERO_RAM+1+4*2)
  CLC 
  ADC #$01
  STA (HERO_RAM+1+4*3)
  LDA #$7E
  STA (HERO_RAM+1+4*4)
  ADC #$01
  STA (HERO_RAM+1+4*5)
  
  JSR AS_StopMusic

  JSR Bloop

  JMP GameEngineDone
SkipGameOver:
  JSR MakeOops 
  JSR ResetHeroHitFlag  
  JMP EnginePlaying_SongAndAudio


;;;;;;;; hero bonus hit check 

SpratzCheckBonus: 
  LDA (REDPILL_RAM+4)    ; bottom part of pill 
  CMP #SPRITE_SPR_Y
  BCC SpratzNoBonus
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS SpratzNoBonus
  LDA (REDPILL_RAM+3+4)
  STA tmp 
  LDA #%01000000
  BIT (HERO_RAM+2)
  BEQ bonus_CheckHitHeroFlipped 
  BNE bonus_CheckHitHero
  
HidePill:
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ SpratzNoBonus
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
SpratzNoBonus: 
  JMP EnginePlaying_SpratzCheckBonusDone

bonus_CheckHitHeroFlipped:
  JSR CheckHitHeroFlipped
  JMP HidePill
  
bonus_CheckHitHero:
  JSR CheckHitHero
  JMP HidePill
  
;;;;;;;;; object hit check 
  
SpratzCheckObjHit: 
  LDA (OBJ_RAM)    
  CMP #SPRITE_SPR_Y
  BCC ObjNoHit
  CMP #(SPRITE_SPR_Y+8*3) ; full length of metasprite
  BCS ObjNoHit
  LDA (OBJ_RAM+3)
  STA tmp 
  LDA #%01000000
  BIT (HERO_RAM+2)
  BEQ obj_CheckHitHero 
  BNE obj_CheckHitHeroFlipped
HideObj:
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ ObjNoHit
  LDA #$F0
  STA (OBJ_RAM+0)
ObjNoHit: 
  JMP EnginePlaying_SpratzCheckObjHitDone

obj_CheckHitHero:
  JSR CheckHitHeroFlipped
  JMP HideObj

obj_CheckHitHeroFlipped:
  JSR CheckHitHero
  JMP HideObj

;;;;;;;;;;;;;;;; score increment 

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

;;;;;;;;;;;;;;;; score decrement 

DecrementScoreDisplay:
  DEC (SCORE_RAM+4*2+1)				; decrement 3rd digit tile number
  LDA (SCORE_RAM+4*2+1)
  CMP #$BF							; check if 3rd digit went past 0
  BNE DecrementScoreDisplayDone		; if not, we're done
  
  LDA #$C9
  STA (SCORE_RAM+4*2+1)				; if so, reset 3rd digit to 0...
  DEC (SCORE_RAM+4+1)				; and decrement 2nd digit tile number
  LDA (SCORE_RAM+4+1)
  CMP #$BF							; check if 2nd digit went past 0
  BNE DecrementScoreDisplayDone		; if not, we're done
  
  LDA #$C9
  STA (SCORE_RAM+4+1)				; if so, reset 2nd digit to 0...
  DEC (SCORE_RAM+1)					; and decrement 1st digit tile number
  LDA (SCORE_RAM+1)
  CMP #$BF							; check if 1st digit went past 0
  BNE DecrementScoreDisplayDone		; if not, we're done
  
  LDA #$C0							; if so (unlikely), reset all digits to 0, reset playerscore, and store 999 in highscore
  STA (SCORE_RAM+4*2+1)
  STA (SCORE_RAM+4+1)
  STA (SCORE_RAM+1)

DecrementScoreDisplayDone: 

  DEC playerScore+1 		; decrement score by 1
  LDA playerScore+1
  CMP #$FF					; check if LSB has wrapped to FF
  BNE DecrementPlayerScoreDone
  DEC playerScore+0			; if so, decrement MSB
  LDA playerScore+0
  CMP #$FF 
  BNE DecrementPlayerScoreDone
  
  LDA #$00
  STA playerScore+1
  STA playerScore+0
DecrementPlayerScoreDone: 

  RTS

;;;;;;;;;;;;;;;;;; player lives 

DecrementLivesDisplay:
  DEC (LIVES_RAM+4+1)				; decrement 3rd digit tile number
  LDA (LIVES_RAM+4+1)
  CMP #$BF							; check if 3rd digit went past 0
  BNE DecrementLivesDisplayDone		; if not, we're done
  
  LDA #$C9
  STA (LIVES_RAM+4+1)				; if so, reset 3rd digit to 0...
  DEC (LIVES_RAM+1)				; and decrement 2nd digit tile number
  LDA (LIVES_RAM+1)
  CMP #$BF							; check if 2nd digit went past 0
  BNE DecrementLivesDisplayDone		; if not, we're done
  
  LDA #$C0							; if so (unlikely), reset all digits to 0, reset playerscore, and store 999 in highscore
  STA (LIVES_RAM+1)
  STA (LIVES_RAM+4+1)

DecrementLivesDisplayDone: 
  DEC playerLives
  RTS

;;;;;;;;;;;;;;;;;; beats check 

OnError: 
  JSR SetSamplePlayedFlag
  JSR DecrementScoreDisplay
  JSR MakeOops
  RTS

MakeOops:
  LDX currentHero
  LDA heroOopsSprites, x
  STA (HERO_RAM+1+4*2)
  CLC 
  ADC #$01 
  STA (HERO_RAM+1+4*3)
  
  LDA #$74
  STA (GUINESS_RAM+1+4*2)
  CLC 
  ADC #$01 
  STA (GUINESS_RAM+1+4*3)
  
  LDA #$0C
  STA faceTimeout
  RTS

OnBeat: 
  JSR IncrementScoreDisplay
  LDA gameFlags
  ORA #HIT_ON_BEAT
  STA gameFlags
  LDA #$20
  STA hitBeatTimeout
  LDA #$00
  STA nextFrame3
  LDA #$32
  STA (HERO_RAM+1+4*4)
  LDA #$10
  STA faceTimeout
  RTS 

;;;;;;; button A 

BufferA: 
  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE BufferDontPlaySampleA

  LDA samplePointer
  JSR PlaySample

BufferDontPlaySampleA: 
  LDA gameFlags
  ORA #BUTTON_A_BUF
  STA gameFlags
  LDA #$02
  STA bufferTimeout

  RTS

ResetBufferA: 
  LDA #BUTTON_A_BUF
  EOR #%11111111
  AND gameFlags
  STA gameFlags
  
  RTS

PlaySampleA:
  LDA #BUTTON_A_BUF
  BIT gameFlags
  BEQ PlaySampleAEnd

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE PlaySampleAEnd

  LDA hitBeatTimeout
  BNE a_Neutral ; not zero -- already hit on beat 

  LDA PAUSE_RAM 
  CMP #$FF
  BEQ a_OnError 
  
  LDA VOLUME_RAM
  BEQ a_OnError
  
  LDA NOISE_RAM
  CMP #$1D
  BEQ a_OnBeat
  CMP #$10
  BEQ a_OnBeat
  CMP #$11
  BEQ a_OnBeat
  JMP a_Neutral

a_OnBeat: 
  JSR OnBeat

  JMP PlaySampleAEnd
	
a_OnError: 

  JSR OnError
  JMP PlaySampleAEnd

a_Neutral:

  JSR ResetBufferA

PlaySampleAEnd: 

  RTS

;;;;;;;; button B 

BufferB: 
  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE BufferDontPlaySampleB
  
  LDA samplePointer
  CLC
  ADC #$01
  JSR PlaySample

BufferDontPlaySampleB: 
  LDA gameFlags
  ORA #BUTTON_B_BUF
  STA gameFlags
  LDA #$02
  STA bufferTimeout
 
  RTS

ResetBufferB: 
  LDA #BUTTON_B_BUF
  EOR #%11111111
  AND gameFlags
  STA gameFlags
  RTS

PlaySampleB:
  LDA #BUTTON_B_BUF
  BIT gameFlags
  BEQ PlaySampleBEnd

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE PlaySampleBEnd

  LDA hitBeatTimeout
  BNE b_Neutral
  
  LDA PAUSE_RAM 
  CMP #$FF
  BEQ b_OnError
  
  LDA VOLUME_RAM
  BEQ b_OnError
  
  LDA NOISE_RAM
  CMP #$1C
  BEQ b_OnBeat
  CMP #$14
  BEQ b_OnBeat
  CMP #$15
  BEQ b_OnBeat
  JMP b_Neutral

b_OnBeat: 
  JSR OnBeat
  JMP PlaySampleBEnd
b_OnError:

  JSR OnError  
  JMP PlaySampleBEnd
  
b_Neutral:

  JSR ResetBufferB
  
PlaySampleBEnd:
  
  RTS

;;;;;;;;;;;;;;;;;;;;; hero Hey / Bop 

SpritesBop: 
  LDX currentHero
  LDA heroBopSprites, x
  STA (HERO_RAM+1+4*3)
  LDA #$29
  STA (HERO_RAM+1+4*5)

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE SpritesBopEnd

  LDA #$0C
  STA faceTimeout

;  LDA NOISE_RAM
;  CMP #$13
;  BCC PlayHey
;  CMP #$19
;  BCS PlayHey
;  JSR OnBeat ; TODO: implement OnError? 
;PlayHey:

  LDA #$08
  JSR PlaySample
SpritesBopEnd: 
  JMP EnginePlaying_ActionsReactDone

;;;;;;;;;;;;;;; samples management 

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
  JMP EnginePlaying_DpadReactDone  

;;;;;;;;;;;;;;;; 

heroDefaultSprites: 
  .byte $00, $60, $40, $68

heroBopSprites: 
  .byte $19, $73, $53, $7B

heroOopsSprites: 
  .byte $84, $A4, $94, $B4

heroDeathSprites: 
  .byte $7C, $9C, $8C, $AC
