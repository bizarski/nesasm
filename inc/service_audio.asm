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
	LDA #$01
	STA initMusic

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
	LDA #$00
	STA initMusic
	
	JSR AS_ClearSound
	
	LDY playingSongNumber
	DEY
	LDA track_number_in_bank_table, y	; song number
	LDX #$00		; 00 for NTSC or $01 for PAL

	JSR INIT_ADDRESS

	JMP GameEngine
	