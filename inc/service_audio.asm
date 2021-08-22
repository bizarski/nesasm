;					-- PUBLIC FUNCTIONS --
AS_ClearSound:
	LDX #$00
	LDA #$00

ClearSoundLoop:
	sta $4000,x
	inx
	cpx #$0F
	bne ClearSoundLoop

	lda #$10
	sta $4010
	lda #$00
	sta $4011
	sta $4012
	STA $4013

	lda #%00001111
	STA $4015
	lda #$C0
	STA $4017
	RTS

AS_StartPlayingCurrentTrack:	; A - current song?
  LDA #MUSIC_INITIALIZED
  EOR #%11111111
  AND soundFlags      
  STA soundFlags

  LDA playingSongNumber
  TAY
  DEY
  ; bankswitch
  LDA banktable, y      ; read a byte from the banktable
  STA banktable, y

  RTS

AS_StopMusic:
	JSR AS_ClearSound

	LDA #$00
	STA playingSongNumber

	RTS

;					-- PRIVATE FUNCTIONS --

InitTrack:
	LDA #MUSIC_INITIALIZED
	ORA soundFlags
	STA soundFlags 
	
	JSR AS_ClearSound
	
	LDY playingSongNumber
	DEY
	LDA trackNumberInBankTable, y	; song number
	LDX #$00		; 00 for NTSC or $01 for PAL

	JSR INIT_ADDRESS

	JMP GameEngine
;

dmc_sample_table:
  .db $0F,$00,(sampleKick-$C000)/64,$0F
  .db $0F,$00,(sampleSnare-$C000)/64,$12
  .db $0F,$00,(sampleCowbell-$C000)/64,$12
  .db $0F,$00,(sampleCowbell2-$C000)/64,$12
  .db $0F,$00,(sampleEffect-$C000)/64,$12
  .db $0F,$00,(sampleSnare2-$C000)/64,$12
  .db $0F,$00,(sampleScratch-$C000)/64,$12
  .db $0F,$00,(sampleHandDrum-$C000)/64,$12
  .db $0F,$00,(sampleKick2-$C000)/64,$12
  .db $0F,$00,(sampleTom-$C000)/64,$12

PlaySample: 
    ASL A
    ASL A
    TAY
	
	LDA #SAMPLE_PLAYED
	BIT soundFlags
	BNE DontPlaySample
	
    LDA     dmc_sample_table+0,y
    STA     $4010                   ; write sample frequency
	
    LDA     dmc_sample_table+1,y
    STA     $4011                   ; write initial delta value
	
    LDA     dmc_sample_table+2,y
    STA     $4012                   ; write sample address
	
    LDA     dmc_sample_table+3,y
    STA     $4013                   ; write sample length
	
	LDA     #$0F
    STA     $4015                   ; turn bit 4 off...
	
    LDA     #$1F
    STA     $4015                   ; ... then on again
	
	LDA soundFlags
	EOR #SAMPLE_PLAYED
	STA soundFlags
DontPlaySample: 
    RTS