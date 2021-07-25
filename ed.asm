  .inesprg 4   ; 4x 16KB PRG code (banks 0, 1, 2, 3); UNROM has 4 or 8 banks
  .ineschr 1   ; 1x  8KB CHR data (bank 4)
  .inesmap 2   ; mapper 0 = NROM, no bank swapping; 2 = UNROM
  .inesmir 1   ; background mirroring

;; DECLARE SOME VARIABLES HERE
  .rsset $0000  ;;start variables at ram location 0

music           .rs 16

buttons1   		.rs 1  ; player 1 gamepad buttons, one bit per button
buttonlatch		.rs 1

pointerLo  		.rs 1   ; pointer variables are declared in RAM
pointerHi  		.rs 1   ; low byte first, high byte immediately after

nextFrame       .rs 1
frameTimeout    .rs 1

currentSong     .rs 1

isSongSpritesShown  .rs 1
isSampleBeingPlayed .rs 1  
isSampleChanged     .rs 1 ; TODO: store 7 flags in one byte


keyHoldTimeout  .rs 1  ; frame counter: rolls over every 256 frames

samplePointer   .rs 1

;;;;;;;;;;;;;;;;;

  .include "inc/const.asm"

;;;;;;;;;;;;;;;

    
	.code
	.bank 0	; 1/4 8k-9999
	.org LOAD_ADDRESS_BANK_1
  incbin "NSFs/1_2_3.nsf"
;	.bank 1 ; 1/4 Ak-B999

	.bank 2	; 2/4 8k-9999
	.org LOAD_ADDRESS_BANK_2
  incbin "NSFs/4_5.nsf"
;	.bank 3 ; 2/4 Ak-B999

	.bank 4	; 3/4 8k-9999
	.org $8000

	.bank 5 ; 3/4 Ak-B999
	.org $A000

	.bank 6 ; (4/4 last bank/fixed) $C000
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


LoadPalettes:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$3F
  STA $2006             ; write the high byte of $3F00 address
  LDA #$00
  STA $2006             ; write the low byte of $3F00 address
  LDX #$00              ; start out at 0
LoadPalettesLoop:
  LDA palette, x        ; load data from address (palette + the value in x)
                          ; 1st time through loop it will load palette+0
                          ; 2nd time through loop it will load palette+1
                          ; 3rd time through loop it will load palette+2
                          ; etc
  STA $2007             ; write to PPU
  INX                   ; X = X + 1
  CPX #$20              ; Compare X to hex $10, decimal 16 - copying 16 bytes = 4 sprites
  BNE LoadPalettesLoop  ; Branch to LoadPalettesLoop if compare was Not Equal to zero
                        ; if compare was equal to 32, keep going down
				
  JSR LoadBackground
  JSR LoadSprites  
  
  LDA #$00
  STA playingSongNumber
  STA initMusic
  STA samplePointer
  
  LDA #TRACK_1
  STA currentSong
  
  LDA #%00000001
  STA isSongSpritesShown
  
  LDA #$05 
  STA frameTimeout

  LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
  STA $2000

  LDA #PPU_SETUP ; enable sprites, enable background
  STA $2001

;;;;;;;;;;;;;

Forever:
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
  JMP EngineTitle			; game is displaying title screen
GameEngine_NotTitle:
  JMP EnginePlaying  
GameEngineDone: 
  RTI             ; return from interrupt
 
;;;;;;;;;;;;;;  
  .include "inc/service_audio.asm"


EngineTitle:
  JSR HideAllSprites
  LDA currentSong 
  STA SPRITE_ARROW
  LDA $18
  JSR EngineTitle_ReactToInput
  
  JMP GameEngineDone

EnginePlaying: 
  LDA #$F0
  STA SPRITE_ARROW
  JSR ShowSongSprites
  JSR AdvanceAnimationFrame 
  JSR AnimateGuitars
  JSR AnimateCymbals
  JSR EnginePlaying_ReactToInput

  LDX initMusic
  CPX #$01
  BEQ GoToInitTrack

  JSR PLAY_ADDRESS

  JMP GameEngineDone
GoToInitTrack: 
  JMP InitTrack
  RTS 


HideAllSprites: 
  LDA isSongSpritesShown
  BIT #%00000001
  BEQ DontHideSprites
  LDX #$00
HideSpritesLoop:
  LDA #$F0
  STA $0400, x
  INX
  INX
  INX  
  INX
  CPX #$A8
  BNE HideSpritesLoop
  LDA #%00000000
  STA isSongSpritesShown
DontHideSprites: 
  RTS 

ShowSongSprites: 
  LDA isSongSpritesShown
  BIT #%00000001
  BNE DontShowSprites 
ShowSparx: 
  LDX #LOW(SPRATZ_RAM)
  LDA #SPRITE_SPR_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_SPR_Y
  JSR ShowMetaSpriteY
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
ShowGuiness: 
  LDX #LOW(GUINESS_RAM)
  LDA #SPRITE_GUIN_X
  JSR ShowMetaSpriteX
  LDA #SPRITE_GUIN_Y
  JSR ShowMetaSpriteY
  LDA #%00000001
  STA isSongSpritesShown
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
ShowInventory:
  LDA #$0D
  STA $04A4
  LDA #$C0
  STA $04A7
ResetSpritesFlag: 
  LDA #%00000001
  STA isSongSpritesShown
DontShowSprites:
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
  STA keyHoldTimeout
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
  BNE EnginePlaying_SpritesMoveLeft
  LDA buttons1 
  AND #BTN_RIGHT 
  BNE EnginePlaying_SpritesMoveRight
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

EnginePlaying_SpritesMoveLeft: 
  JMP SpritesMoveLeft
  RTS 

EnginePlaying_SpritesMoveRight: 
  JMP SpritesMoveRight
  RTS 
  
EnginePlaying_SpritesBop: 
  JMP SpritesBop
  RTS 
  
EnginePlaying_PlayingSelectPressed: 
  JMP PlayingSelectPressed
  RTS 

EnginePlaying_MoveGuiness:
  LDX #$7C
  LDA #SPRITE_GUIN_X-2
  JSR ShowMetaSpriteX
  LDA #SPRITE_GUIN_Y
  JSR ShowMetaSpriteY
  
  LDA buttons1 
  AND #BTN_A
  BNE PlaySampleA
  LDA buttons1 
  AND #BTN_B
  BNE PlaySampleB
exitMoveGuiness:
  RTS 


PlaySampleA: 
  LDA samplePointer
  JSR PlaySample
  RTS 
PlaySampleB: 
  LDA samplePointer
  CLC
  ADC #$01
  JSR PlaySample
  RTS 


EnginePlaying_ResetTriggers: 
ResetHead: 
  LDA #$00 
  STA (SPRATZ_RAM+1)
  LDA #$01 
  STA (SPRATZ_RAM+1+4)
  LDA #$10
  STA (SPRATZ_RAM+1+4*2)
  LDA #$11
  STA (SPRATZ_RAM+1+4*3)
ResetGuiness: 
  JSR ShowGuiness
ResetSamples: 
  LDA #%00000000
  STA isSampleBeingPlayed
  STA isSampleChanged
  RTS

SpritesBop: 
  LDA #$08 
  STA SPRATZ_RAM+1
  LDA #$09 
  STA (SPRATZ_RAM+1+4)
  LDA #$18
  STA (SPRATZ_RAM+1+4*2)
  LDA #$19
  STA (SPRATZ_RAM+1+4*3)

  LDA isSampleChanged
  BIT #%00000001
  BNE SkipUpdateSample  
UpdateInventory: 
  LDA (INVENTORY_RAM+1)
  CLC
  ADC #$10 
  CMP #$5E
  BNE StoreInventoryChange
  LDA #$0E
StoreInventoryChange: 
  STA (INVENTORY_RAM+1)
UpdateSamplePointer:
  LDA samplePointer
  CLC 
  ADC #$02
  CMP #$0A
  BNE StoreSamplePointer
  LDA #$00
StoreSamplePointer:
  STA samplePointer
  LDA #%00000001
  STA isSampleChanged
SkipUpdateSample: 
  RTS

TitleStartPressed: 
  JSR ResetPPU

  LDA currentSong
  CMP #TRACK_1
  BEQ PlayTrack1 
  CMP #TRACK_2
  BEQ PlayTrack2
  CMP #TRACK_3
  BEQ PlayTrack3
  CMP #TRACK_4
  BEQ PlayTrack4
  CMP #TRACK_5
  BEQ PlayTrack5
  RTS 

PlayTrack1:
  LDA #$01
  STA playingSongNumber
  
  JSR LoadSong1Background
  JSR AS_StartPlayingCurrentTrack
  RTS 

PlayTrack2: 
  LDA #$02
  STA playingSongNumber

  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  RTS 

PlayTrack3: 
  LDA #$03
  STA playingSongNumber

  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  RTS

PlayTrack4: 
  LDA #$04
  STA playingSongNumber

  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  RTS 

PlayTrack5: 
  LDA #$05
  STA playingSongNumber

  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  RTS

PlayingSelectPressed:
  JSR AS_StopMusic
  
  JSR ResetPPU
  JSR LoadBackground  
  RTS 

ResetPPU: 
  LDA #PPU_SETUP
  EOR #%00011000
  STA $2001
  RTS

ArrowMoveUp: 
  LDA #$00
  CMP buttonlatch
  BEQ StillMovingUp
  JMP StopMovingUp
StillMovingUp:
  LDA SPRITE_ARROW
  SEC            
  SBC #$08       
  STA SPRITE_ARROW
  STA currentSong
  JSR Bleep
  LDA #$01
  STA buttonlatch
  LDA #$20 
  STA keyHoldTimeout
StopMovingUp:
  JSR ResetLatch
  RTS

ArrowMoveDown: 
  LDA #$00
  CMP buttonlatch
  BEQ StillMovingDown
  JMP StopMovingDown
StillMovingDown: 
  LDA SPRITE_ARROW
  CLC            
  ADC #$08       
  STA SPRITE_ARROW
  STA currentSong
  JSR Bleep
  LDA #$01
  STA buttonlatch
  LDA #$20 
  STA keyHoldTimeout
StopMovingDown:
  JSR ResetLatch
  RTS

SpritesMoveLeft:
  JSR AnimateWalk
  LDX #$03
SpritesMoveLeftLoop: 
  LDA $0400, x
  SEC            
  SBC #$01       
  STA $0400, x
  INX
  INX
  INX  
  INX
  CPX #$1B
  BNE SpritesMoveLeftLoop
  RTS


SpritesMoveRight:
  JSR AnimateWalk
  LDX #$03
SpritesMoveRightLoop: 
  LDA $0400, x
  CLC            
  ADC #$01       
  STA $0400, x
  INX
  INX
  INX
  INX
  CPX #$1B
  BNE SpritesMoveRightLoop
  RTS
  
ResetLatch:	
  LDA keyHoldTimeout
  BNE DontResetLatch
   
  LDA #$00 
  STA keyHoldTimeout
  STA buttonlatch
DontResetLatch:
  RTS 

StartClock: 
  LDA keyHoldTimeout
  BEQ StopKeyClock
  DEC keyHoldTimeout
StopKeyClock: 
  LDA frameTimeout
  BEQ StopFrameClock
  DEC frameTimeout
StopFrameClock: 
  RTS 
  
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

;;;;;;;;;;;;;;;;;;;;


  .bank 7 ; (4/4 last bank/fixed) $E000
  .org $E000


LoadBackground:
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
  LDX #$00              ; start at 0
LoadSpritesLoop:
  LDA sprites, x        ; load data from address (sprites +  x)
  STA $0400, x          ; store into RAM address ($0400 + x)
  INX                   ; X = X + 1
  CPX #$A8              ; Compare X 
  BNE LoadSpritesLoop   ; Branch to LoadSpritesLoop if compare was Not Equal to zero
                        ; if compare was equal to 32, keep going down
  RTS 

LoadSong1Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song1_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song1_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 
 
LoadSong2Background: 
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address

  LDA #low(song2_background)
  STA pointerLo       ; put the low byte of the address of background into pointer
  LDA #HIGH(song2_background)
  STA pointerHi       ; put the high byte of the address into pointer
  LDX #$00            ; start at pointer + 0
  LDY #$00
  JSR LoadNametable
  RTS 

LoadNametable:
  LDA [pointerLo], Y					; load data using indirect indexed addressing (Y must be used in this mode)
  STA $2007							; write to PPU
  INY
  CPY #$FF
  BNE LoadNametable  ; branch when Y reaches $FF = 255 (255 bytes have been loaded).
  LDA [pointerLo], Y					; since the loop ends before Y=$FF is used, run one more time to get to 256 bytes.
  STA $2007							; write to PPU
  INY								; increment Y to overflow back to $00 and prepare for next round
  INX								; increment X now that the first of four blocks of 256 bytes is done
  INC pointerHi						; move offset to next 256-byte block of memory
  CPX #$04
  BNE LoadNametable	; when X=$04, 4 rounds of 256 are complete for a full 1024 bytes read.
  RTS

  .include "inc/sprites.asm"

palette:
  .incbin "bg.pal"
  .db $0F,$00,$10,$37,$0F,$00,$21,$37,$0F,$16,$00,$10,$0F,$02,$38,$3C ;SPRITE

  
menu_background:
  .incbin "menu.nam"

song1_background:
  .incbin "song1.nam"
  
song2_background:
  .incbin "song2.nam"


;;;;;;;;;;;;;;;;;;;;

banktable:              ; Write to this table to switch banks.
	.byte $00, $00, $00, $01, $01, $05, $06, $07, $08, $09, $0A, $0B
track_number_in_bank_table:
  .byte $00, $01, $02, $00, $01, $00, $00, $00, $00, $00, $00, $00

;;;;;;;;;;;;;;;;

  .org $FFFA     ;first of the three vectors starts here
  .dw NMI        ;when an NMI happens (once per frame if enabled) the 
                   ;processor will jump to the label NMI:
  .dw RESET      ;when the processor first turns on or is reset, it will jump
                   ;to the label RESET:
  .dw 0          ;external interrupt IRQ is not used in this tutorial

;;;;;;;;;;;;;;  
  
  
  .bank 8
  .org $0000
  .incbin "ed.chr"   ;includes 8KB graphics file from SMB1 
  
;;;;;;;;;;;;;;;;;;;;;;;

