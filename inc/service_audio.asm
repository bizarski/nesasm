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
	
	LDA playingSongNumber  
    CMP #$03
    BEQ Glitch1
	CMP #$0B
    BEQ Glitch2

GlitchDone: 
	
	LDA soundFlags
	EOR #SAMPLE_PLAYED
	STA soundFlags
DontPlaySample: 
    RTS
	
	
Glitch1: 
    LDA xpos  
	ADC NOISE_RAM
	SBC samplePointer
	TAX
	LDA xpos 
	ADC KICK_RAM
	LDX animationClock
	STA $027C, x 
	
	LDA counter  
	STA $2006           
    STA $2006          
    STA $2007          
	JMP GlitchDone

Glitch2: 
    LDA xpos  	
	SBC samplePointer
	SBC (SPRATZ_RAM+3)
	LDX animationClock
	STA $0200, x 
    JMP GlitchDone