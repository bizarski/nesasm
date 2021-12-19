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

DoGlitch: 
	LDA playingSongNumber  
    CMP #$03
    BNE SkipGlitch
	
    LDA xpos  
	CLC
	ADC NOISE_RAM
	SBC samplePointer
	TAX
	LDA xpos 
	CLC
	ADC KICK_RAM
	LDX animationClock
	STA $0292, x 
	
	LDA counter  
	STA $2006           
    STA $2006          
    STA $2007          
	
SkipGlitch:
    RTS