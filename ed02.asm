  .inesprg 16  ; UOROM
  .ineschr 0   ; 1x  8KB CHR data (bank 4)
  .inesmap 2   ; mapper 0 = NROM, no bank swapping; 2 = UNROM
  .inesmir 1   ; background mirroring

;; DECLARE SOME VARIABLES HERE
  .rsset $0050  ;;start variables at ram location 0

  .include "inc/variables.asm"

;;;;;;;;;;;;;;;;;

  .include "inc/const.asm"

;;;;;;;;;;;;;;; banks 
    
	.code

	.bank 0	; C	
	.org $8000
chrdata: 
  .incbin "ed.chr"  
  
    .bank 2 	; D
    .org $8000
  .include "bg-stage.asm"

	.bank 4	; 2
	.org LOAD_ADDRESS_BANK_1
  incbin "NSFs/1_2.nsf"

	.bank 6	; 3
	.org LOAD_ADDRESS_BANK_2
  incbin "NSFs/3.nsf"

	.bank 8	; 4
	.org LOAD_ADDRESS_BANK_3
  incbin "NSFs/4.nsf"

	.bank 10 ; 5
	.org LOAD_ADDRESS_BANK_4
  incbin "NSFs/5.nsf"

    .bank 12 ; 6
	.org LOAD_ADDRESS_BANK_5
  incbin "NSFs/6_7.nsf"
	
	.bank 14	; 7
	.org LOAD_ADDRESS_BANK_6
  incbin "NSFs/8.nsf"
	
	.bank 16	; 8
	.org LOAD_ADDRESS_BANK_7
  incbin "NSFs/9.nsf"
	
	.bank 18	; 9
	.org LOAD_ADDRESS_BANK_8
  incbin "NSFs/10.nsf" 
	
	.bank 20	; A
	.org LOAD_ADDRESS_BANK_9
  incbin "NSFs/11.nsf"
	
	.bank 22	; B
	.org LOAD_ADDRESS_BANK_10
  incbin "NSFs/12.nsf"
	
	.bank 24 	; C
	.org LOAD_ADDRESS_BANK_11
  incbin "NSFs/13.nsf"
	
	.bank 26	; D
	
	.bank 30
  
	.org $C000
  
  .include "inc/samples.asm" ; 55 55 55 95 AA 2A 95 E0
  
;;;;; reset console params and clear RAM 
  
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
  
;;;;;;; PAL/NTSC recognition 
;;;;;;; wait for the next NTSC vertical blank (PAL and Dendy would take longer)

   LDX #$70
cd1:
   LDY #$35
cd2: 
   DEY
   BNE cd2
   DEX
   BNE cd1

   ;detect whether the frame rate is 60Hz or 50Hz
   LDA $2002
   STA frameRateIs60
  
;;;;;; initialize memory 
  
  JSR LoadCHRAM
  
  LDA #$00
  STA playingSongNumber
  STA samplePointer
  STA gameFlags
  STA soundFlags
  STA xpos
  STA hitBeatTimeout
  STA playerScore+0
  STA playerScore+1					; reset score
  STA highScore+0
  STA highScore+1					; reset score
    
  JSR LoadSongPalette
  JSR LoadSprites  
  
  LDA #TRACK_1
  STA currentSong
  STA ARROW_RAM
  
  LDA #$05 
  STA frameTimeout

  STA animationClock
  
  LDA #%10010000 ; enable NMI, sprites from Pattern 0, background from Pattern 1
  STA $2000

  JSR LoadMenuBackground

  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001
  
;;;;;;;;;;;;;;;;;;;;;;;;;;

Forever:
  JMP Forever     ; jump back to Forever, infinite loop

;;;;;;;;;;;;;;;;;;;;;;;;;;
   
NMI:

  LDA #$00
  STA $2003       		; set the low byte (00) of the RAM address
  LDA #$04
  STA $4014       		; set the high byte (02) of the RAM address, start the transfer
  JSR StartClock
  JSR ReadController1  	; get the current button data for player 1
  
GameEngine:  
  LDA playingSongNumber
  CMP #$00
  BNE GameEngine_Playing	; need to use JMP here because relative addressing used by BEQ goes out of range
  LDA #HERO_HIT 
  BIT gameFlags
  BNE GameEngine_GameOver
  JMP EngineTitle			; game is displaying title screen
GameEngine_Playing:
  JMP EnginePlaying  
GameEngine_GameOver: 
  JMP EngineGameOver
GameEngineDone: 

  RTI
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;
  

;;;;; audio controls 

  .include "inc/service_audio.asm"

;;;;; engine title 

EngineTitle:
  JSR DisplayHighScore

;;;;; react to menu input 

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
  JMP GameEngineDone
 
EngineTitle_TitleStartPressed: 
  JMP TitleStartPressed

EngineTitle_ArrowMoveUp: 
  JMP ArrowMoveUp

EngineTitle_ArrowMoveDown: 
  JMP ArrowMoveDown
 
;;;;;;; game over state 

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
  JMP PlayingSelectPressed
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; game playing state 
  
EnginePlaying:   
  
  JSR AdvanceXPos 				; pills and objects random position
  JSR AdvanceAnimationFrame 	; for all animations 
  
;;;;;;;; coins and tomatoes animation and hit detection 

  LDA playingSongNumber  
  CMP #$09 ; song is Red Pilled, no coins nor tomatoes there
  BEQ EnginePlaying_SkipObjs
  
  JSR AnimateObjs
  
  JMP SpratzCheckObjHit
EnginePlaying_SpratzCheckObjHitDone:

  LDA playingSongNumber  
  CMP #$04 ; song is not High Stakes - no bonus 
  BNE EnginePlaying_SkipObjs

  JSR CheckPlayerBonusFlag

EnginePlaying_SkipObjs: 

;;;;;;; UFO 

  LDA playingSongNumber  
  CMP #$07 ; song is not Systematic Chaos - no UFO
  BNE EnginePlaying_SkipUFO
  
  JSR AnimateUFO
  
EnginePlaying_SkipUFO:
  
;;;;;;; pills and hit detection  
  
  LDA playingSongNumber  
  CMP #$09 ; song is not Red Pilled - no pills
  BNE EnginePlaying_SkipPills
  JSR AnimatePills
  JSR AnimatePills2
  
  JMP SpratzCheckHit
EnginePlaying_SpratzCheckHitDone:

  LDA #HERO_HIT 
  BIT gameFlags
  BNE EnginePlaying_PlayerHit
  
  JMP SpratzCheckBonus
EnginePlaying_SpratzCheckBonusDone: 

  JSR CheckPlayerBonusFlag

EnginePlaying_SkipPills:  

;;;;;;;; check death 

  LDA playingSongNumber  
  CMP #$04 ; no death in High Stakes
  BEQ EnginePlaying_SkipHeroHitCheck
  CMP #$09 ; different death in Red Pilled 
  BEQ EnginePlaying_SkipHeroHitCheck

  LDA #HERO_HIT 
  BIT gameFlags
  BNE EnginePlaying_PlayerHit
  
EnginePlaying_SkipHeroHitCheck: 

  JSR ResetHeroHead

;;;;;;;; input reactions 

  JMP EnginePlaying_ReactToActions
EnginePlaying_ActionsReactDone: 

  JMP EnginePlaying_ReactToDpad
EnginePlaying_DpadReactDone: 
  
  LDA #HIT_ON_BEAT
  BIT gameFlags
  BNE EnginePlaying_ResetBeatFlag
  
EnginePlaying_ResetBeatFlagDone: 

  JSR PlaySampleA
  JSR PlaySampleB
  
;;;;;;;;; routine animations 

  JSR AnimateGuitars
  JSR AnimateCymbals
  
;;;;;;;;; song and audio 
  
EnginePlaying_SongAndAudio: 
  LDA playingSongNumber
  BEQ EnginePlaying_SkipMusic

  LDA #MUSIC_INITIALIZED
  BIT soundFlags
  BEQ EnginePlaying_GoToInitTrack

  JSR PLAY_ADDRESS
  
  LDA IS_PLAYING_RAM
  BEQ EnginePlaying_SongFinished

EnginePlaying_SkipMusic:
  JMP GameEngineDone
EnginePlaying_GoToInitTrack: 
  JMP InitTrack
EnginePlaying_SongFinished: 
  JSR MarkSongAsFinished
  JMP PlayingSelectPressed

EnginePlaying_ResetBeatFlag: 
  LDA hitBeatTimeout
  CMP #$1B
  BCS SkipResetBeatFlag
  LDA #HIT_ON_BEAT
  EOR #%11111111
  AND gameFlags
  STA gameFlags
SkipResetBeatFlag: 
  JMP EnginePlaying_ResetBeatFlagDone

EnginePlaying_PlayerHit: 
  JMP PlayerHit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckPlayerBonusFlag: 
  LDA #HERO_HIT 
  BIT gameFlags
  BEQ PlayerNoBonus
  JSR ResetHeroHitFlag
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay
  JSR IncrementScoreDisplay  
  JSR IncrementScoreDisplay
PlayerNoBonus: 
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
  LDX #LOW(ELMO_RAM)
  LDA #$04
  JSR ChangeElmoTiles
ShowAldo: 
  LDX #LOW(ALDO_RAM)
  LDA #SPRITE_ALDO_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_ALDO_Y
  JSR ShowMetaSpriteY
ShowGuin:
  JSR ShowGuiness
ShowBass:
  LDX #LOW(BASS_RAM)
  LDA #$3E
  JSR ShowGuitX
  
  LDX #LOW(BASS_RAM)
  LDA #$2A
  JSR ChangeGuitTiles  
ShowGuitars: 
  LDX #LOW(GUITAR_RAM)
  LDA #$B3
  JSR ShowGuitX
  
  LDX #LOW(GUITAR_RAM)
  LDA #$0A
  JSR ChangeGuitTiles  

ShowCymbals: 
  LDX #LOW(CYMBALS_RAM)
  LDA #SPRITE_CYM_X
  STA ($0400+3), x
  CLC 
  ADC #$08
  STA ($0400+3+4), x
  ADC #$08
  STA ($0400+3+4*2), x
  ADC #$08
  STA ($0400+3+4*3), x
  LDA #SPRITE_CYM_Y
  STA $0400, x
  STA ($0400+4), x
  STA ($0400+4*2), x
  STA ($0400+4*3), x
ShowLives: 
  LDA #$0D
  STA LIVES_RAM
  STA (LIVES_RAM+4)
ShowScore: 
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
  LDX #LOW(HERO_RAM)
  LDA #SPRITE_SPR_X
  JSR ShowSpratzX
  LDA #SPRITE_SPR_Y
  JSR ShowSpratzY
  LDX currentHero
  LDA heroDefaultSprites, x
  LDX #LOW(HERO_RAM)
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
  LDA #$20
  STA ($0400+1+4*4), x
  ADC #$01
  STA ($0400+1+4*5), x
ChangeHeroTilesEnd:
  RTS 

ChangeElmoTiles: 
  STA ($0400+1), x
  CLC
  ADC #$01
  STA ($0400+1+4), x
  ADC #$0F
  STA ($0400+1+4*2), x
  ADC #$01
  STA ($0400+1+4*3), x
  ADC #$0F
  STA ($0400+1+4*4), x
  ADC #$01
  STA ($0400+1+4*5), x
ChangeElmoTilesEnd:
  RTS 

ChangeGuitTiles: 
  STA ($0400+1), x
  CLC
  ADC #$01
  STA ($0400+1+4), x
  ADC #$01
  STA ($0400+1+4*2), x
  ADC #$0E
  STA ($0400+1+4*3), x
  ADC #$01
  STA ($0400+1+4*4), x
  ADC #$01
  STA ($0400+1+4*5), x
  RTS

ShowGuitX: 
  STA ($0400+3), x
  STA ($0400+3+4*3), x
  CLC 
  ADC #$08
  STA ($0400+3+4), x
  STA ($0400+3+4*4), x
  ADC #$08
  STA ($0400+3+4*2), x
  STA ($0400+3+4*5), x
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
  
EnginePlaying_ReactToDpad: 
  LDA buttons1 
  AND #BTN_LEFT 
  BNE EnginePlaying_SpratzMoveLeft
  LDA buttons1 
  AND #BTN_RIGHT 
  BNE EnginePlaying_SpratzMoveRight
  LDA buttons1 
  AND #BTN_UP
  BNE EnginePlaying_ChangeSamples
; below will be executed if NOT LEFT/RIGHT/UP
  LDA #SAMPLE_CHANGED    		; 00000001
  EOR #%11111111                ; 11111110
  AND soundFlags
  STA soundFlags
  JMP EnginePlaying_DpadReactDone
  
;;;;;;;;;;;;;;;;;;;;;;;

EnginePlaying_ReactToActions: 
  LDA buttons1 
  AND #BTN_SELECT
  BNE EnginePlaying_PlayingSelectPressed
  LDA buttons1 
  AND #BTN_A
  BNE EnginePlaying_MoveGuiness
  LDA buttons1 
  AND #BTN_B
  BNE EnginePlaying_MoveGuiness
; below will be executed if NOT SELECT/A/B
; reset Guiness
  JSR ShowGuiness
  LDA buttons1 
  AND #BTN_DOWN 
  BNE EnginePlaying_SpritesBop
; below will be executed if NOT SELECT/A/B/DOWN 
; reset samples 
  JSR ResetSamples
  JMP EnginePlaying_ActionsReactDone
  
ResetSamples: 
  LDA #SAMPLE_PLAYED    ; 00000001
  EOR #%11111111 		; 11111110
  AND soundFlags      
  STA soundFlags
  
  LDA bufferTimeout
  BNE ResetSamplesEnd
  
  JSR ResetBufferA
  JSR ResetBufferB
  
ResetSamplesEnd: 
  RTS

EnginePlaying_SpratzMoveLeft: 
  LDA playingSongNumber
  CMP #$0B
  BEQ FlipLeftToRight
  JMP SpratzMoveLeft
FlipLeftToRight: 
  JMP SpratzMoveRight
 

EnginePlaying_SpratzMoveRight: 
  LDA playingSongNumber
  CMP #$0B
  BEQ FlipRightToLeft
  JMP SpratzMoveRight
FlipRightToLeft: 
  JMP SpratzMoveLeft
  
EnginePlaying_ChangeSamples: 
  JMP ChangeSamples
  
EnginePlaying_SpritesBop: 
  JMP SpritesBop
  
EnginePlaying_PlayingSelectPressed:
  JMP PlayingSelectPressed

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
  JMP EnginePlaying_ActionsReactDone

e_PlaySampleA: 
  JSR BufferA
  JMP EnginePlaying_ActionsReactDone

e_PlaySampleB: 
  JSR BufferB
  JMP EnginePlaying_ActionsReactDone

ResetHeroHitFlag: 
  LDA #HERO_HIT
  EOR #%11111111
  AND gameFlags
  STA gameFlags
  
  RTS 

ResetHeroHead: 
  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BNE ResetHeroHeadDone
  
  LDA faceTimeout 
  BNE ResetHeroHeadDone

  LDX currentHero
  LDA heroDefaultSprites, x
  LDX #LOW(HERO_RAM)
  JSR ChangeHeroTiles
  
  LDA #$54
  STA (GUINESS_RAM+1+4*2)
  CLC
  ADC #$01 
  STA (GUINESS_RAM+1+4*3)
ResetHeroHeadDone:
  RTS 

TitleStartPressed: 
  JSR SpratzDirRight

  JSR ResetHeroHitFlag
  
  LDA #$F0
  STA ARROW_RAM
  
  JSR ResetPPU
  JSR ResetPlayerScore
  JSR ShowSongSprites

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
  JMP GameEngineDone

goto_PlayTrack1:
  JMP PlayTrack1
goto_PlayTrack2:
  JMP PlayTrack2
goto_PlayTrack3:
  JMP PlayTrack3
goto_PlayTrack4:
  JMP PlayTrack4
goto_PlayTrack5:
  JMP PlayTrack5
goto_PlayTrack6:
  JMP PlayTrack6
goto_PlayTrack7:
  JMP PlayTrack7
goto_PlayTrack8:
  JMP PlayTrack8
goto_PlayTrack9:
  JMP PlayTrack9
goto_PlayTrack10:
  JMP PlayTrack10
goto_PlayTrack11:
  JMP PlayTrack11
goto_PlayTrack12:
  JMP PlayTrack12
goto_PlayTrack13:
  JMP PlayTrack13
goto_FinishPlayTrack: 
  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001
  JSR DisplayLives
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

;;;;;;;;;;

MarkSongAsFinished:
  LDX playingSongNumber
  LDA completionMap, x
  CPX #$09
  BCC storeProgressIn1
  ORA (completionFlags+1)
  STA (completionFlags+1)
storeProgressIn1: 
  ORA completionFlags
  STA completionFlags
  RTS

DisplayLives:
  LDA playerLives
  CMP #99
  BEQ Show99Lives
  CMP #0
  BEQ Show0Lives

  LDA #$C0
  STA (LIVES_RAM+1)
  LDA #$C1 
  STA (LIVES_RAM+1+4)

  JMP DisplayLivesDone
Show99Lives:

  LDA #$C9
  STA (LIVES_RAM+1) 
  STA (LIVES_RAM+1+4)

  JMP DisplayLivesDone
Show0Lives:
  LDA #$C0
  STA (LIVES_RAM+1) 
  STA (LIVES_RAM+1+4)
DisplayLivesDone:
  RTS

PlayingSelectPressed:
  JSR ResetPPU
  JSR HideAllSprites
  JSR ShowIndicatorSprites
    
  LDA #$00
  STA pointerLo
  STA pointerHi
  STA tmp
  STA nextFrame
  STA nextFrame3
  STA frameTimeout
  STA faceTimeout
  STA hitBeatTimeout
  STA bufferTimeout
  STA animationClock
  
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
  
  JSR AS_StopMusic
  
  JSR LoadSongPalette ; LoadPalette9
  JSR LoadMenuBackground  
  
  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001
  
  JMP GameEngineDone 

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
  JMP GameEngineDone
;;;;;;;;;;;
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
  JMP GameEngineDone
  
;;;;;;;;;;;;

  .bank 31 ; (4/4 last bank/fixed) $E000
  .org $E000

  .include "inc/hero_movement.asm"

  .include "inc/animations.asm"
  
ShowIndicatorSprites: 
  LDX #$00
BigIndicatorLoop:
ShowIndicatorLoop: 
  LDA #$2F
  STA (BASS_RAM+1), x
  INX
  INX
  INX
  INX
  CPX #$34
  BNE ShowIndicatorLoop
  LDA #(TRACK_1-1)
  LDX #$00
ShowIndicatorLoop2: 
  STA BASS_RAM, x
  ADC #$08
  INX
  INX
  INX
  INX
  CPX #$34
  BNE ShowIndicatorLoop2
  LDX #$00
  LDA #$CF
ShowIndicatorLoop3: 
  STA (BASS_RAM+3), x
  INX
  INX
  INX
  INX
  CPX #$34
  BNE ShowIndicatorLoop3

  LDY #$01
  LDX #$00
  
HideIndicatorLoop: 
  LDA completionMap, y
  STA tmp
  LDA playingSongNumber
  CPY #$09
  BCC CheckCompletionIn1
  LDA tmp
  BIT (completionFlags+1)
  BEQ HideCheckbox
  JMP CheckHideEnd
CheckCompletionIn1: 
  LDA tmp
  BIT completionFlags
  BEQ HideCheckbox
  JMP CheckHideEnd
HideCheckbox: 
  LDA #$F0
  STA BASS_RAM, x
  JMP CheckHideEnd
CheckHideEnd: 
  INY
  INX
  INX
  INX
  INX
  CPY #$14
  BNE HideIndicatorLoop
  
  RTS 
  
Bleep:
  ; enable channel
  lda #%00000001
  sta $4015
  ; square 1
  LDA #%10110100
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

  .include "inc/banktable.asm"

  .include "inc/play_routines.asm"

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

LoadCHRAM:
  LDY #$00
  ; bankswitch
  LDA otherbanks, y      ; read a byte from the banktable
  STA otherbanks, y
  
  LDA #low(chrdata)
  STA pointerLo
  LDA #HIGH(chrdata)  ; LOAD THE SOURCE ADDRESS INTO A POINTER IN ZERO PAGE
  STA pointerHi
  
  STY $2006             ; write the high byte of $2000 address
  STY $2006             ; write the low byte of $2000 address
  LDX #32      ; NUMBER OF 256-BYTE PAGES TO COPY
chramloop:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  BNE chramloop  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
  INC pointerHi						; move offset to next 256-byte block of memory
  DEX								; increment X now that the first of four blocks of 256 bytes is done
  BNE chramloop	; when X=$04, 4 rounds of 256 are complete for a full 1024 bytes read.
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

  .include "inc/backgrounds.asm"
  
menu_background:
  .incbin "menu.nam"

;;;;;;;;;;;;;;;;

  .org $FFFA     ;first of the three vectors starts here
  .dw NMI        ;when an NMI happens (once per frame if enabled) the 
                   ;processor will jump to the label NMI:
  .dw RESET      ;when the processor first turns on or is reset, it will jump
                   ;to the label RESET:
  .dw 0          ;external interrupt IRQ is not used in this tutorial

;;;;;;;;;;;;;;;;;;;;;;;

