;					-- PUBLIC FUNCTIONS --
AS_ClearSound:
	LDX #$00
	LDA #$00

ClearSoundLoop:
	STA $4000,x
	INX
	CPX #$0F
	BNE ClearSoundLoop

	LDA #$10
	STA $4010
	LDA #$00
	STA $4011
	STA $4012
	STA $4013

	LDA #%00001111
	STA $4015
	LDA #$C0
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
	
	LDA frameRateIs60
	BNE LoadNTSC	
	LDX #$01		; 00 for NTSC or $01 for PAL
	JMP InitTrackFromBank
LoadNTSC: 
	LDX #$00		; 00 for NTSC or $01 for PAL

InitTrackFromBank: 

	LDA trackNumberInBankTable, y	; song number
	
	JSR INIT_ADDRESS

	JMP GameEngineDone
;

PlaySample: 
    ASL A
    ASL A
    TAY
	
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
    BNE SkipGlitch1
	
    LDA xpos  
	CLC
	ADC NOISE_RAM
	SBC samplePointer
	TAX
	LDA xpos 
	CLC
	ADC KICK_RAM
	LDX animationClock
	STA $027C, x 
	
	LDA counter  
	STA $2006           
    STA $2006          
    STA $2007          
	
SkipGlitch1:
    LDA playingSongNumber  
	CMP #$0B
    BNE SkipGlitch2

    LDA xpos  	
	SBC samplePointer
	SBC (SPRATZ_RAM+3)
	LDX animationClock
	STA $0200, x 

SkipGlitch2: 
	
	LDA soundFlags
	EOR #SAMPLE_PLAYED
	STA soundFlags

    RTS