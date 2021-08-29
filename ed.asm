  .inesprg 8   ; 4x 16KB PRG code (banks 0, 1, 2, 3); UNROM has 4 or 8 banks
  .ineschr 1   ; 1x  8KB CHR data (bank 4)
  .inesmap 2   ; mapper 0 = NROM, no bank swapping; 2 = UNROM
  .inesmir 1   ; background mirroring

;; DECLARE SOME VARIABLES HERE
  .rsset $0000  ;;start variables at ram location 0

  .include "inc/variables.asm"

;;;;;;;;;;;;;;;;;

  .include "inc/const.asm"

;;;;;;;;;;;;;;;

    
	.code
	.bank 0	; 1/4 8k-9999
	.org LOAD_ADDRESS_BANK_1
  incbin "NSFs/1_2_3.nsf"

	.bank 2	; 2/4 8k-9999
	.org LOAD_ADDRESS_BANK_2
  incbin "NSFs/4_5.nsf"

	.bank 4	; 3/4 8k-9999
	.org LOAD_ADDRESS_BANK_3
  incbin "NSFs/6_7.nsf"

	.bank 6 ; (4/4 last bank/fixed) $C000
	.org LOAD_ADDRESS_BANK_4
  incbin "NSFs/8_9.nsf"

    .bank 8
	.org LOAD_ADDRESS_BANK_5
  incbin "NSFs/10.nsf"
	
	.bank 10
	.org LOAD_ADDRESS_BANK_6
  incbin "NSFs/11_12.nsf"
	
	.bank 12
	.org LOAD_ADDRESS_BANK_7
  incbin "NSFs/13.nsf"
	
	.bank 14
  
	.org $C000
  
  .include "inc/samples.asm"
  
RESET:
  SEI          ; disable IRQs
  CLD          ; disable decimal mode
  LDX #$40
  STX $4017    ; disable APU frame IRQ
  LDX #$FF
  TXS          ; Set up stack
  INX          ; now X = 0
  STX $2000    ; disable NMI
  STX $2001    ; disable rendering
  STX $4010    ; disable DMC IRQs

vblankwait1:       ; First wait for vblank to make sure PPU is ready
  BIT $2002
  BPL vblankwait1

clrmem:
  LDA #$00
  STA $0000, x
  STA $0100, x
  STA $0300, x
  STA $0200, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  LDA #$FE
  STA $0400, x
  INX
  BNE clrmem
      
	  
vblankwait2:      ; Second wait for vblank, PPU is ready after this
  BIT $2002
  BPL vblankwait2

  JSR LoadPalette9
				
  JSR LoadMenuBackground
  JSR LoadSprites  
  
  LDA #$00
  STA playingSongNumber
  STA samplePointer
  STA gameFlags
  STA soundFlags
  STA xpos
  STA playerScore+0
  STA playerScore+1					; reset score
  STA highScore+0
  STA highScore+1					; reset score
  
  LDA #TRACK_1
  STA currentSong
  STA ARROW_RAM
  
  LDA #$05 
  STA frameTimeout

  STA animationClock

  LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
  STA $2000

  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001

;;;;;;;;;;;;;

Forever:
AdvanceXPos: 
  LDA xpos 
  CLC 
  ADC #$08 
  CMP #$B8
  BCC DontResetXPos
  LDA #$40
  INC counter
DontResetXPos: 
  STA xpos
  JMP Forever     ;jump back to Forever, infinite loop

;;;;;;;;;;;;;;;

   
NMI:
  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001
  LDA #$00
  STA $2003       ; set the low byte (00) of the RAM address
  LDA #$04
  STA $4014       ; set the high byte (02) of the RAM address, start the transfer
  JSR StartClock
  JSR ReadController1  ;;get the current button data for player 1
  
GameEngine:  
  LDA playingSongNumber
  CMP #$00
  BNE GameEngine_NotTitle	; need to use JMP here because relative addressing used by BEQ goes out of range
  LDA #HERO_HIT 
  BIT gameFlags
  BNE GameEngine_GameOver
  JMP EngineTitle			; game is displaying title screen
GameEngine_NotTitle:
  JMP EnginePlaying  
GameEngine_GameOver: 
  JMP EngineGameOver
GameEngineDone: 
  RTI             ; return from interrupt
 
;;;;;;;;;;;;;;  
  .include "inc/service_audio.asm"


EngineTitle:
  JSR DisplayHighScore
  JSR EngineTitle_ReactToInput
  
  JMP GameEngineDone

EngineGameOver: 
  LDA buttons1 
  AND #BTN_SELECT
  BNE EngineGameOver_Reset
  LDA buttons1 
  AND #BTN_START
  BNE EngineGameOver_Reset
  JMP GameEngineDone
  
EngineGameOver_Reset: 
  JSR ResetHeroHitFlag  
  JSR PlayingSelectPressed
  JMP GameEngineDone
  
EnginePlaying:   
  JSR AdvanceAnimationFrame 
  JSR AnimateGuitars
  JSR AnimateCymbals
  
  LDA playingSongNumber  
  CMP #$04
  BNE EnginePlaying_SkipCoins
  
  JSR AnimateCoins
  JSR SpratzCheckBonus2
  LDA #HERO_HIT 
  BIT gameFlags
  BNE PlayerBonus
  
EnginePlaying_SkipCoins: 

  LDA playingSongNumber  
  CMP #$07
  BNE EnginePlaying_SkipUFO
  
  JSR AnimateUFO
  
EnginePlaying_SkipUFO:
  
  LDA playingSongNumber  
  CMP #$09
  BNE EnginePlaying_SkipPills
  JSR AnimatePills
  JSR AnimatePills2
  JSR SpratzCheckHit
  LDA #HERO_HIT 
  BIT gameFlags
  BNE PlayerHit
  JSR SpratzCheckBonus
  LDA #HERO_HIT 
  BIT gameFlags
  BNE PlayerBonus
EnginePlaying_SkipPills:  

  LDA WOO_RAM
  CMP #$F0
  BEQ SkipAnimateWoo
  JSR AnimateWoo
SkipAnimateWoo: 

  JSR EnginePlaying_ReactToInput
  
  LDA playingSongNumber
  BEQ SkipMusic

  LDA #MUSIC_INITIALIZED
  BIT soundFlags
  BEQ GoToInitTrack

  JSR PLAY_ADDRESS
  
  LDA IS_PLAYING_RAM
  BEQ SongFinished

SkipMusic:
  JMP GameEngineDone
GoToInitTrack: 
  JMP InitTrack
  RTS 

SongFinished: 
  JSR PlayingSelectPressed
  JMP GameEngineDone	
  RTS

PlayerHit: 
  LDA heroSparx+2
  STA (SPRATZ_RAM+1+4*2)
  CLC 
  ADC #$01
  STA (SPRATZ_RAM+1+4*3)
  ADC #$01
  STA (SPRATZ_RAM+1+4*4)
  ADC #$01
  STA (SPRATZ_RAM+1+4*5)
  
  JSR EnginePlaying_StopMusic
  JSR Bloop
  JMP GameEngineDone

  RTS 

PlayerBonus: 
  JSR ResetHeroHitFlag
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay  
  
  JSR SayWoo
  jmp EnginePlaying_SkipPills
  RTS 

HideAllSprites: 
  LDX #$00
HideSpritesLoop:
  LDA #$F0
  STA $0400, x
  INX
  INX
  INX  
  INX
  CPX #$E8
  BNE HideSpritesLoop
DontHideSprites: 
  RTS 

ShowSongSprites: 
ShowElmo: 
  LDX #LOW(ELMO_RAM)
  LDA #SPRITE_ELM_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_ELM_Y
  JSR ShowMetaSpriteY
ShowAldo: 
  LDX #LOW(ALDO_RAM)
  LDA #SPRITE_ALDO_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_ALDO_Y
  JSR ShowMetaSpriteY
ShowGuin:
  JSR ShowGuiness
ShowCymbals: 
  LDX #LOW(CYMBALS_RAM)
  LDA #SPRITE_CYM_X
  STA ($0400+3), x
  CLC 
  ADC #$08
  STA ($0400+3+4), x
  CLC 
  ADC #$08
  STA ($0400+3+4*2), x
  CLC 
  ADC #$08
  STA ($0400+3+4*3), x
  LDA #SPRITE_CYM_Y
  STA $0400, x
  STA ($0400+4), x
  STA ($0400+4*2), x
  STA ($0400+4*3), x
ShowScore: 
  LDA #$0D
  STA SCORE_RAM
  STA (SCORE_RAM+4)
  STA (SCORE_RAM+4*2)
  LDA #$E0
  STA (SCORE_RAM+3)
  LDA #$E8
  STA (SCORE_RAM+3+4)
  LDA #$F0
  STA (SCORE_RAM+3+4*2)
ShowInventory:
  LDA #$0D
  STA INVENTORY_RAM
  LDA #$C0
  STA (INVENTORY_RAM+3)
ShowSparx: 
  LDX #LOW(SPRATZ_RAM)
  LDA #SPRITE_SPR_X
  JSR ShowSpratzX
  LDA #SPRITE_SPR_Y
  JSR ShowSpratzY
  LDX #LOW(SPRATZ_RAM)
  LDA currentHero
  JSR ChangeHeroTiles
DontShowSprites:
  RTS 
  
ShowGuiness: 
  LDX #LOW(GUINESS_RAM)
  LDA #SPRITE_GUIN_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_GUIN_Y
  JSR ShowMetaSpriteY
  RTS  
  
ShowMetaSpriteX: 
  STA ($0400+3), x
  STA ($0400+3+4*2), x
  STA ($0400+3+4*4), x
  CLC 
  ADC #$08
  STA ($0400+3+4), x
  STA ($0400+3+4*3), x
  STA ($0400+3+4*5), x
  RTS
  
ShowMetaSpriteY:
  STA $0400, x
  STA ($0400+4), x
  CLC 
  ADC #$08
  STA ($0400+4*2), x
  STA ($0400+4*3), x
  CLC
  ADC #$08
  STA ($0400+4*4), x
  STA ($0400+4*5), x
  RTS 

ShowSpratzX: 
  JSR ShowMetaSpriteX
  SEC
  SBC #$08
  STA ($0400+3+4*6), x
  CLC 
  ADC #$08
  STA ($0400+3+4*7), x
  RTS
ShowSpratzY:
  JSR ShowMetaSpriteY
  CLC
  ADC #$08
  STA ($0400+4*6), x
  STA ($0400+4*7), x
  RTS 

ChangeHeroTiles: 
  STA ($0400+1), x
  CLC
  ADC #$01
  STA ($0400+1+4), x
  ADC #$0F
  STA ($0400+1+4*2), x
  ADC #$01
  STA ($0400+1+4*3), x
  RTS 

ReadController1:
  LDA #$01
  STA $4016
  LDA #$00
  STA $4016
  LDX #$08
ReadController1Loop:
  LDA $4016
  LSR A            ; bit0 -> Carry
  ROL buttons1     ; bit0 <- Carry
  DEX
  BNE ReadController1Loop
  RTS 
  
EngineTitle_ReactToInput:
  LDA buttons1 
  AND #BTN_START
  BNE EngineTitle_TitleStartPressed 
  LDA buttons1 
  AND #BTN_UP
  BNE EngineTitle_ArrowMoveUp
  LDA buttons1 
  AND #BTN_DOWN 
  BNE EngineTitle_ArrowMoveDown
  LDA buttons1 
  AND #%00000000
  BNE DoNothing 
  LDA #$00
  STA buttonlatch
DoNothing: 
  RTS
  
EngineTitle_TitleStartPressed: 
  JMP TitleStartPressed
  RTS 
EngineTitle_ArrowMoveUp: 
  JMP ArrowMoveUp
  RTS
EngineTitle_ArrowMoveDown: 
  JMP ArrowMoveDown
  RTS 

EnginePlaying_ReactToInput: 
  LDA buttons1 
  AND #BTN_LEFT 
  BNE EnginePlaying_SpratzMoveLeft
  LDA buttons1 
  AND #BTN_RIGHT 
  BNE EnginePlaying_SpratzMoveRight
  LDA buttons1 
  AND #BTN_DOWN 
  BNE EnginePlaying_SpritesBop
  LDA buttons1 
  AND #BTN_SELECT
  BNE EnginePlaying_PlayingSelectPressed
  LDA buttons1 
  AND #BTN_A
  BNE EnginePlaying_MoveGuiness
  LDA buttons1 
  AND #BTN_B
  BNE EnginePlaying_MoveGuiness
  LDA buttons1 
  AND #%00000000
  BEQ EnginePlaying_ResetTriggers
  RTS

EnginePlaying_SpratzMoveLeft: 
  LDA playingSongNumber
  CMP #$0B
  BEQ FlipLeftToRight
  JMP SpratzMoveLeft
FlipLeftToRight: 
  JMP SpratzMoveRight
  RTS 
 

EnginePlaying_SpratzMoveRight: 
  LDA playingSongNumber
  CMP #$0B
  BEQ FlipRightToLeft
  JMP SpratzMoveRight
FlipRightToLeft: 
  JMP SpratzMoveLeft
  RTS 
  
EnginePlaying_SpritesBop: 
  JMP SpritesBop
  RTS 
  
EnginePlaying_PlayingSelectPressed:
  JMP PlayingSelectPressed
  RTS 

EnginePlaying_MoveGuiness:
  LDX #LOW(GUINESS_RAM)
  LDA #SPRITE_GUIN_X-2
  JSR ShowMetaSpriteX
  
  LDA buttons1 
  AND #BTN_A
  BNE e_PlaySampleA
  LDA buttons1 
  AND #BTN_B
  BNE e_PlaySampleB
exitMoveGuiness:
  RTS 

e_PlaySampleA: 
  JMP PlaySampleA
  RTS 

e_PlaySampleB: 
  JMP PlaySampleB
  RTS

EnginePlaying_ResetTriggers: 
ResetHead: 
  LDX #LOW(SPRATZ_RAM)
  LDA currentHero
  JSR ChangeHeroTiles
  LDA #$21
  STA (SPRATZ_RAM+1+4*5)
ResetGuiness: 
  JSR ShowGuiness
ResetSamples: 
  LDA #SAMPLE_PLAYED    ; 00000001
  EOR #%11111111 		; 11111110
  AND soundFlags      
  STA soundFlags

  LDA #SAMPLE_CHANGED    ; 00000001
  EOR #%11111111 		 ; 11111110
  AND soundFlags      
  STA soundFlags
  
  RTS



ResetHeroHitFlag: 
  LDA #HERO_HIT
  EOR #%11111111
  AND gameFlags
  STA gameFlags
  
  RTS 

TitleStartPressed: 
  JSR SpratzDirRight

  JSR ResetHeroHitFlag
  
  LDA #$F0
  STA ARROW_RAM
  
  JSR ResetPlayerScore
  JSR ShowSongSprites
  JSR ResetPPU

  LDA currentSong
  CMP #TRACK_1
  BEQ goto_PlayTrack1 
  CMP #TRACK_2
  BEQ goto_PlayTrack2
  CMP #TRACK_3
  BEQ goto_PlayTrack3
  CMP #TRACK_4
  BEQ goto_PlayTrack4
  CMP #TRACK_5
  BEQ goto_PlayTrack5
  CMP #TRACK_6
  BEQ goto_PlayTrack6
  CMP #TRACK_7
  BEQ goto_PlayTrack7
  CMP #TRACK_8
  BEQ goto_PlayTrack8
  CMP #TRACK_9
  BEQ goto_PlayTrack9
  CMP #TRACK_10
  BEQ goto_PlayTrack10
  CMP #TRACK_11
  BEQ goto_PlayTrack11
  CMP #TRACK_12
  BEQ goto_PlayTrack12
  CMP #TRACK_13
  BEQ goto_PlayTrack13
  
 
FinishStartPressed:

  RTS 

  .include "inc/play_routines.asm"

PlayingSelectPressed:
  JSR ResetPPU
  JSR HideAllSprites
  
  JSR LoadPalette9
  JSR LoadMenuBackground  
  
   ; Check and update highscore
  LDA highScore+0
  CMP playerScore+0
  BCC HighScoreUpdate		; if highscore MSB < playerscore MSB, update highscore
  BNE HighScoreEnd			; but, if highscore MSB > playerscore MSB, skip update
							; (past this point, we know highscore MSB <= playerscore MSB)
  LDA highScore+1
  CMP playerScore+1
  BCC HighScoreUpdate		; else if highscore LSB < playerscore LSB, update highscore
  JMP HighScoreEnd			; else, skip update
  
HighScoreUpdate:
  LDA playerScore+0
  STA highScore+0
  LDA playerScore+1
  STA highScore+1
  
HighScoreEnd:
  
  LDA highScore+0
  STA scoreLo
  LDA highScore+1
  STA scoreHi
  
  LDA #$C0
  STA (SCORE_RAM+1)
  STA (SCORE_RAM+1+4)
  STA (SCORE_RAM+1+4*2)
  
  
  LDA currentSong 
  STA ARROW_RAM
  
EnginePlaying_StopMusic: 

  JSR AS_StopMusic
  
  RTS 

DisplayHighScore: 
  LDA #$BE 
  STA SCORE_RAM
  STA (SCORE_RAM+4)
  STA (SCORE_RAM+4*2)
  LDA #$92
  STA (SCORE_RAM+3)
  LDA #$9A
  STA (SCORE_RAM+3+4)
  LDA #$A2
  STA (SCORE_RAM+3+4*2)
 
  LDA scoreHi
  CMP #$00
  BNE ScoreLoopSmall
  LDA scoreLo
  CMP #$00
  BEQ DisplayHighScoreDone
  CMP #$FF 
  BEQ DisplayHighScoreDone
ScoreLoopSmall:
  JSR IncrementScoreDisplay
  DEC scoreHi
  LDA scoreHi
  CMP #$00
  BNE ScoreLoopSmall
  DEC (scoreLo) 
  LDA (scoreLo) 
  CMP #$FF 
  BNE ScoreLoopSmall
DisplayHighScoreDone:   
  RTS 

ResetPlayerScore:
  LDA #$C0
  STA (SCORE_RAM+1)
  STA (SCORE_RAM+1+4)
  STA (SCORE_RAM+1+4*2)
  LDA #$00
  STA playerScore+0
  STA playerScore+1
  RTS 

ResetPPU: 
  LDA #PPU_SETUP
  EOR #%00011000
  STA $2001
  RTS

ArrowMoveUp: 
  LDA ARROW_RAM
  CMP #MENU_X_LIMIT_TOP
  BEQ StopMovingUp
  LDA #$00
  CMP buttonlatch
  BEQ StillMovingUp
  JMP StopMovingUp
StillMovingUp:
  LDA ARROW_RAM
  SEC            
  SBC #$08       
  STA ARROW_RAM
  STA currentSong
  JSR Bleep
  LDA #$01
  STA buttonlatch
StopMovingUp:
  RTS

ArrowMoveDown: 
  LDA ARROW_RAM
  CMP #MENU_X_LIMIT_BOTTOM
  BEQ StopMovingDown
  LDA #$00
  CMP buttonlatch
  BEQ StillMovingDown
  JMP StopMovingDown
StillMovingDown: 
  LDA ARROW_RAM
  CLC            
  ADC #$08       
  STA ARROW_RAM
  STA currentSong
  JSR Bleep
  LDA #$01
  STA buttonlatch
StopMovingDown:
  RTS

  .include "inc/hero_movement.asm"
  
  .include "inc/animations.asm"
  
  
Bleep:
  ; enable channel
  lda #%00000001
  sta $4015
  ; square 1
  LDA #%10000111
  STA $4000
  ; sweep   
  LDA #%10001001
  STA $4001
  LDA #%11110000
  ; timer
  STA $4002
  ; length counter and timer
  LDA #%00001000
  STA $4003
  RTS


Bloop:
  ; enable channel
  lda #%00000001
  sta $4015
  ; square 1
  LDA #%10000111
  STA $4000
  ; sweep   
  LDA #%11110000
  STA $4001
  LDA #%10011001
  ; timer
  STA $4002
  ; length counter and timer
  LDA #%00001000
  STA $4003
  RTS

LoadMenuBackground:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(menu_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(menu_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 


LoadSprites:
  LDX #$00
LoadPillsLoop: 
  LDA pillsprites, x     
  STA $0400, x         
  INX                   
  CPX #$14             
  BNE LoadPillsLoop   


  LDX #$00              ; start at 0
LoadSpritesLoop:
  LDA sprites, x        ; load data from address (sprites +  x)
  STA $0414, x          ; store into RAM address ($0400 + x)
  INX                   ; X = X + 1
  CPX #$D4              ; Compare X 
  BNE LoadSpritesLoop   ; Branch to LoadSpritesLoop if compare was Not Equal to zero
                        ; if compare was equal to 32, keep going down
  RTS 


spritepalette: 
  .db $0F,$00,$10,$37,$0F,$00,$21,$37,$0F,$16,$00,$10,$0F,$02,$38,$3C ;SPRITE

bgpalette:
  .incbin "bg.pal"

bgpalette2:
  .incbin "bg2.pal"

bgpalette4:
  .incbin "bg4.pal"

bgpalette5:
  .incbin "bg5.pal"

bgpalette6:
  .incbin "bg6.pal"

bgpalette9:
  .incbin "bg9.pal"
  
bgpalette11:
  .incbin "bg11.pal"
  
bgpalette13:
  .incbin "bg13.pal"

  .include "inc/sprites.asm"

;;;;;;;;;;;;;;;;;;;;


  .bank 15 ; (4/4 last bank/fixed) $E000
  .org $E000

  .include "bg-stage.asm"
  .include "inc/backgrounds.asm"
  
menu_background:
  .incbin "menu.nam"

;;;;;;;;;;;;;;;;;;;;

banktable:              ; Write to this table to switch banks.
  .byte $00, $00, $00, $01, $01, $02, $02, $03, $03, $04, $05, $05, $06
trackNumberInBankTable:
  .byte $00, $01, $02, $00, $01, $00, $01, $00, $01, $00, $00, $01, $00
heroSparx: 
  .byte $00, $08, $7C
heroZappa: 
  .byte $60, $62
heroIvo: 
  .byte $40, $42
heroFreddy: 
  .byte $68, $6A

;;;;;;;;;;;;;;;;

  .org $FFFA     ;first of the three vectors starts here
  .dw NMI        ;when an NMI happens (once per frame if enabled) the 
                   ;processor will jump to the label NMI:
  .dw RESET      ;when the processor first turns on or is reset, it will jump
                   ;to the label RESET:
  .dw 0          ;external interrupt IRQ is not used in this tutorial

;;;;;;;;;;;;;;  
  
  
  .bank 16
  .org $0000
  .incbin "ed.chr"   ;includes 8KB graphics file from SMB1 
  
;;;;;;;;;;;;;;;;;;;;;;;

