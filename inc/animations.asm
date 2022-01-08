AdvanceXPos: 
  LDA xpos 
  CLC 
  ADC #$08 
  ADC (HERO_RAM+3)/10
  SBC counter/10
  CMP #$B8
  BCC DontResetXPos
  LDA #$40
DontResetXPos: 
  STA xpos
  INC counter
  RTS 

StartClock: 
  LDA frameTimeout
  BEQ SkipFrameTimeoutUpdate
  DEC frameTimeout
SkipFrameTimeoutUpdate: 
  LDA animationClock
  BNE DontResetAnimationClock
  LDA #$06 
  STA animationClock
DontResetAnimationClock:
  SEC 
  SBC #$01
  STA animationClock  
FlashTimeoutClock: 
  LDA hitBeatTimeout
  BEQ BufferTimeoutClock
  DEC hitBeatTimeout
BufferTimeoutClock: 
  LDA bufferTimeout
  BEQ FaceTimeoutClock
  DEC bufferTimeout
FaceTimeoutClock: 
  LDA faceTimeout
  BEQ EndClock
  DEC faceTimeout
EndClock: 
  RTS 

AdvanceAnimationFrame:
  LDA frameTimeout
  BNE DontChangeFrame
  LDA nextFrame
  CMP #$03 
  BNE DontResetFrame
  LDA #$FF 
  STA nextFrame
DontResetFrame:
  CLC 
  INC nextFrame
  LDA #$05
  STA frameTimeout
ResetFrame3: 
  LDA nextFrame3
  CMP #$03 
  BEQ DontChangeFrame
  INC nextFrame3
DontChangeFrame:   
  RTS 

AnimateWalk: 
  LDX nextFrame
  LDA animLegsLeft, x
  STA (HERO_RAM+4*6+1)
  LDA animLegsRight, x
  STA (HERO_RAM+4*6+1+4)
  RTS 

AnimateGuitars: 
  LDA nextFrame
  CMP #$01
  BNE SkipMoveGuitarsUp
  LDA #SPRITE_BASS_Y
  JSR MoveBass 
  LDA #SPRITE_GUITAR_Y
  JSR MoveGuitars
SkipMoveGuitarsUp: 
  LDA nextFrame
  CMP #$03
  BNE SkipMoveGuitarsDown
  LDA #SPRITE_BASS_Y
  SEC
  SBC #$01
  JSR MoveBass 
  LDA #SPRITE_GUITAR_Y
  SBC #$01
  JSR MoveGuitars
SkipMoveGuitarsDown: 
  RTS

MoveGuitars: 
  STA GUITAR_RAM
  STA (GUITAR_RAM+4)
  STA (GUITAR_RAM+4+4)
  CLC 
  ADC #$08
  STA (GUITAR_RAM+8+4) 
  STA (GUITAR_RAM+8+4*2)  
  STA (GUITAR_RAM+8+4*3)   
  RTS 

MoveBass: 
  STA BASS_RAM
  STA (BASS_RAM+4)
  STA (BASS_RAM+4+4)
  CLC 
  ADC #$08
  STA (BASS_RAM+8+4)
  STA (BASS_RAM+8+4*2) 
  STA (BASS_RAM+8+4*3)    
  RTS  
  
AnimateCymbals: 
  LDX #$94	
  LDA nextFrame
  CMP #$01
  BNE SkipCymbalsChangeFrameA
  LDA #$48
  JSR CymbalsChangeFrame
SkipCymbalsChangeFrameA:
  LDA nextFrame
  CMP #$03
  BNE SkipCymbalsChangeFrameB
  LDA #$58
  JSR CymbalsChangeFrame
SkipCymbalsChangeFrameB:
  RTS

CymbalsChangeFrame: 
  STA CYMBALS_RAM+1
  CLC 
  ADC #$01 
  STA (CYMBALS_RAM+1+4)
  ADC #$01 
  STA (CYMBALS_RAM+1+4*2)
  ADC #$01 
  STA (CYMBALS_RAM+1+4*3)
  RTS 
 
;;;;;;;;;
 
AnimateUFO: 
  LDA (UFO_RAM+3)
  CMP #$F0					; check UFO horizontal position
  BCC SkipDelaySpawn

  LDA #$F0 
  STA (UFO_RAM)
  STA (UFO_RAM+4)

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BEQ SkipUFO
  
  LDA samplePointer
  CMP #$04
  BNE SkipUFO
  
  LDA PAUSE_RAM 
  CMP #$FF
  BEQ SkipUFO 
  
  LDA NOISE_RAM
  CMP #$13
  BCC SkipUFO
  CMP #$19
  BCS SkipUFO
  
  JMP SkipDelaySpawn

SkipDelaySpawn: 
  LDA (UFO_RAM)
  CMP #$25 
  BEQ SkipResetUFO
  
  LDA #$25 
  STA (UFO_RAM)
  STA (UFO_RAM+4)
  
  LDA #$00
  STA (UFO_RAM+3)
  LDA #$08
  STA (UFO_RAM+4+3)
SkipResetUFO: 
  INC (UFO_RAM+3)
  INC (UFO_RAM+3)
  INC (UFO_RAM+4+3)
  INC (UFO_RAM+4+3)
SkipUFO:
  RTS  

;;;;;;;;;;;;;;;;; blue pill

DelaySpawnBluePill: 
  LDA BLUEPILL_RAM
  CMP #$C0
  BEQ BluePillDrop
  ; not #$C0, meaning player made a hit on the beat 
  LDX nextFrame3
  LDA animPillDeath, x
  STA (BLUEPILL_RAM+1)
  CLC
  ADC #$10
  STA (BLUEPILL_RAM+5)
  LDA hitBeatTimeout
  CMP #$01
  BNE SkipFall
BluePillDrop: 
  LDA #$F0
  STA (BLUEPILL_RAM+0)
  STA (BLUEPILL_RAM+4)
  JMP DontDelay 

InitializeXPosition: 
  LDA xpos
  STA (BLUEPILL_RAM+3)
  STA (BLUEPILL_RAM+3+4)
  JMP b_PillMove
  
InitializeYPosition: 
  LDA #$44
  STA (BLUEPILL_RAM+0)
  STA (BLUEPILL_RAM+0+4)
  JMP b_PillInitX
  
AnimatePills: 
  LDA BLUEPILL_RAM
  CMP #$C0
  BEQ b_DelaySpawn
  LDA hitBeatTimeout
  CMP #$00
  BNE b_DelaySpawn ; not equal to 0, means player hit on the beat 
DontDelay:
  LDA BLUEPILL_RAM
  CMP #$F0
  BEQ InitializeYPosition
b_PillInitX:
  LDA BLUEPILL_RAM
  CMP #$44
  BEQ InitializeXPosition
b_PillMove: 
  LDA #$5C
  STA (BLUEPILL_RAM+1)
  LDA #$6C
  STA (BLUEPILL_RAM+5)
  LDA BLUEPILL_RAM
  CLC
  ADC #$01
  STA BLUEPILL_RAM
  ADC #$08
  STA (BLUEPILL_RAM+4)
SkipFall:
  RTS
  
b_DelaySpawn:
  JMP DelaySpawnBluePill
  
;;;;;;;;;;;;;;; Red Pill 
  
DelaySpawnRedPill: 
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
  
  LDA (BLUEPILL_RAM+0)	; top part of pill 
  CMP #$74
  BCC SkipFallRedPill		; less than
  CMP #$A0
  BCS SkipFallRedPill		; greater than 
  
  LDA (KICK_RAM+3)
  CMP #$F0 
  BCS DontDelay2
  JMP SkipFallRedPill
  
InitializeXPositionRed:     
  LDA (BLUEPILL_RAM+3)
  CMP xpos 
  BEQ r_SkipFall
  LDA xpos
  STA (REDPILL_RAM+3)
  STA (REDPILL_RAM+3+4)
  JMP r_PillMove

InitializeYPositionRed:     
  LDA #$44
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+0+4)
  JMP r_PillInitX

r_SkipFall: 
  JMP SkipFallRedPill

AnimatePills2: 
  LDA REDPILL_RAM
  CMP #$C0
  BEQ r_DelaySpawn
  CMP #$F0
  BEQ r_DelaySpawn
DontDelay2:
  LDA REDPILL_RAM
  CMP #$F0
  BEQ InitializeYPositionRed
r_PillInitX:
  LDA REDPILL_RAM
  CMP #$44
  BEQ InitializeXPositionRed
r_PillMove:
  LDA REDPILL_RAM
  CLC
  ADC #$01
  STA REDPILL_RAM
  ADC #$08
  STA (REDPILL_RAM+4)
SkipFallRedPill:
  RTS
  
r_DelaySpawn:
  JMP DelaySpawnRedPill
  
;;;;;;;;;;;;;;; coin / tomato
  
DelaySpawnObj: 
  LDA OBJ_RAM
  CMP #$C0
  BEQ ObjDrop
  ; not #$C0, meaning player made a hit on the beat 
  LDX nextFrame3
  LDA animObjDeath, x
  STA (OBJ_RAM+1)
  LDA hitBeatTimeout
  CMP #$01
  BNE SkipFallObj
ObjDrop: 
  LDA #$F0
  STA OBJ_RAM
  JMP DontDelayObj 
  
InitializeXPositionObj:     
  LDA xpos
  STA (OBJ_RAM+3)
  JMP c_ObjMove

InitializeYPositionObj:     
  LDA #$44
  STA (OBJ_RAM+0)
  JMP c_ObjInitX

c_SkipFall: 
  JMP SkipFallObj

AnimateObjs: 
  LDA OBJ_RAM
  CMP #$C0
  BEQ c_DelaySpawn
  LDA hitBeatTimeout
  CMP #$00
  BNE c_DelaySpawn
DontDelayObj:
  LDA OBJ_RAM
  CMP #$F0
  BEQ InitializeYPositionObj
c_ObjInitX:
  LDA OBJ_RAM
  CMP #$44
  BEQ InitializeXPositionObj
c_ObjMove:

  LDX nextFrame
  LDA playingSongNumber
  CMP #$02
  BEQ PutHearts
  CMP #$04
  BEQ PutCoins
  CMP #$0B
  BEQ PutBottles
  LDA #%00000010
  STA (OBJ_RAM+2)
  LDA animTomatos, x
  JMP StorePatternInRam
c_PutCoins: 
  JMP PutCoins
c_PutHearts: 
  JMP PutHearts
c_PutBottles: 
  JMP PutBottles
StorePatternInRam:
  STA (OBJ_RAM+1)
  INC OBJ_RAM
  LDA currentSong
  CMP #TRACK_10
  BNE SkipFallObj
  INC OBJ_RAM
SkipFallObj:
  RTS
    
c_DelaySpawn: 
  JMP DelaySpawnObj


PutCoins: 
  LDA #%00000000
  STA (OBJ_RAM+2)
  LDA animCoins, x
  JMP StorePatternInRam
PutHearts: 
  LDA #%00000010
  STA (OBJ_RAM+2)
  LDA animHearts, x
  JMP StorePatternInRam
PutBottles: 
  LDA #%00000001
  STA (OBJ_RAM+2)
  LDA animBottles, x
  JMP StorePatternInRam

;;;;;;;;;;;;; animation tables 

animCoins: 
  .db $5E, $6E, $5E, $6E
  
animTomatos: 
  .db $5F, $6F, $5F, $6F
  
animBottles: 
  .db $47, $47, $47, $57
  
animHearts: 
  .db $0F, $0F, $1F, $0F
  
animObjDeath:
  .db $4F, $3F, $3F, $18
  
animPillDeath: 
  .db $5D, $3D, $1D, $18
  
animLegsLeft: 
  .db $30, $12, $30, $22

animLegsRight: 
  .db $31, $13, $31, $23 
  
animWoo: 
  .db %00000010, $00000000, %00000010, %00000001