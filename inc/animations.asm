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
  RTS 

AdvanceAnimationFrame:
  LDA frameTimeout
  BNE DontChangeFrame
  LDX #$00
  LDA nextFrame
  CMP #$03 
  BNE DontResetFrame
  LDA #$FF 
  STA nextFrame
DontResetFrame:
  CLC 
  ADC #$01 
  STA nextFrame
  LDA #$05
  STA frameTimeout
DontChangeFrame:   
  RTS 


AnimateWoo: 
  LDX nextFrame
  LDA animWoo, x
  STA (WOO_RAM+2)     ; attributes
  STA (WOO_RAM+2+4)
  STA (WOO_RAM+2+4*2)
  STA (WOO_RAM+2+4*3)
  DEC (WOO_RAM)
  DEC (WOO_RAM+4)
  DEC (WOO_RAM+4*2)
  DEC (WOO_RAM+4*3)
  RTS 

AnimateWalk: 
  LDX nextFrame
  LDA animLegsLeft, x
  STA (SPRATZ_RAM+4*6+1)
  LDA animLegsRight, x
  STA (SPRATZ_RAM+4*6+1+4)
  RTS 

AnimateGuitars: 
  LDA nextFrame
  CMP #$01
  BEQ MoveGuitarsUp
  LDA nextFrame
  CMP #$03
  BEQ MoveGuitarsDown
  RTS
  
MoveGuitarsUp: 
  LDA #SPRITE_BASS_Y
  JSR MoveBass 
  LDA #SPRITE_GUITAR_Y
  JSR MoveGuitars
  RTS 

MoveGuitarsDown: 
  LDA #SPRITE_BASS_Y
  SEC
  SBC #$01
  JSR MoveBass 
  LDA #SPRITE_GUITAR_Y
  SEC
  SBC #$01
  JSR MoveGuitars
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
  BEQ CymbalsChangeFrameA
  LDA nextFrame
  CMP #$03
  BEQ CymbalsChangeFrameB
  RTS

CymbalsChangeFrameA: 
  LDA #$48
  JSR CymbalsChangeFrame
  RTS 
CymbalsChangeFrameB: 
  LDA #$58
  JSR CymbalsChangeFrame
  RTS 
CymbalsChangeFrame: 
  STA CYMBALS_RAM+1
  CLC 
  ADC #$01 
  STA (CYMBALS_RAM+1+4)
  CLC
  ADC #$01 
  STA (CYMBALS_RAM+1+4*2)
  CLC
  ADC #$01 
  STA (CYMBALS_RAM+1+4*3)
  RTS 
 
 
  
AnimateUFO: 
  LDA (UFO_RAM+3)
  CMP #$FC
  BCC SkipDelaySpawn

  LDA #SAMPLE_PLAYED
  BIT soundFlags
  BEQ ResetUFO
  
  LDA samplePointer
  CMP #$04
  BNE ResetUFO
  
  LDA PAUSE_RAM 
  CMP #$FF
  BEQ ResetUFO 
  
  LDA NOISE_RAM
  CMP #$13
  BCC ResetUFO
  CMP #$19
  BCS ResetUFO
  
  JMP SkipDelaySpawn
  
ResetUFO: 
  LDA #$F0 
  STA (UFO_RAM)
  STA (UFO_RAM+4)
  JMP SkipUFO
SkipDelaySpawn: 
  LDA #$25 
  STA (UFO_RAM)
  STA (UFO_RAM+4)
  INC (UFO_RAM+3)
  INC (UFO_RAM+3)
  INC (UFO_RAM+4+3)
  INC (UFO_RAM+4+3)
SkipUFO:
  RTS 
  
  
 
DelaySpawnBluePill:
  LDA #$F0
  STA (BLUEPILL_RAM+0)
  STA (BLUEPILL_RAM+4)
  LDA (KICK_RAM+4)
  SEC
  CMP #$A0 
  BCS DontDelay
  JMP SkipFall
  
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
  CMP #$F0
  BEQ b_DelaySpawn
DontDelay:
  LDA BLUEPILL_RAM
  CMP #$F0
  BEQ InitializeYPosition
b_PillInitX:
  LDA BLUEPILL_RAM
  CMP #$44
  BEQ InitializeXPosition
b_PillMove:
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
  
DelaySpawnRedPill: 
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
  LDA (KICK_RAM+3)
  SEC
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
  LDA (BLUEPILL_RAM+0)
  CMP #($44 - $10)
  BCC continue_inity2
  CMP #($44 + $10)
  BCS continue_inity2
  JMP SkipFallRedPill
  
continue_inity2:
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
  
DelaySpawnCoin: 
  LDA #$F0
  STA (COIN_RAM+0)
  LDA (KICK_RAM)
  SEC
  CMP #$C0 
  BCS DontDelayCoin
  JMP SkipFallCoin
  
InitializeXPositionCoin:     
  LDA xpos
  STA (COIN_RAM+3)
  JMP c_CoinMove

InitializeYPositionCoin:     
  LDA #$44
  STA (COIN_RAM+0)
  JMP c_CoinInitX

c_SkipFall: 
  JMP SkipFallCoin

AnimateCoins: 
  LDA COIN_RAM
  CMP #$C0
  BEQ c_DelaySpawn
  CMP #$F0
  BEQ c_DelaySpawn
DontDelayCoin:
  LDA COIN_RAM
  CMP #$F0
  BEQ InitializeYPositionCoin
c_CoinInitX:
  LDA COIN_RAM
  CMP #$44
  BEQ InitializeXPositionCoin
c_CoinMove:

  LDX nextFrame
  LDA animCoins, x
  STA (COIN_RAM+1)

  INC COIN_RAM
SkipFallCoin:

  RTS
  
c_DelaySpawn: 
  JMP DelaySpawnCoin

animCoins: 
  .db $5E, $6E, $5E, $6E
  
animLegsLeft: 
  .db $30, $12, $30, $22

animLegsRight: 
  .db $31, $13, $31, $23 
  
animWoo: 
  .db %00000010, $00000000, %00000010, %00000001