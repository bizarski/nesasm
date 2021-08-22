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


AnimateWalk: 
  LDY #$00
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
 
DelaySpawn1:
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
  JMP DelaySpawn1
  
DelaySpawn2: 
  LDA #$F0
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+4)
  LDA (KICK_RAM+3)
  SEC
  CMP #$F0 
  BCS DontDelay2
  JMP SkipFall2
  
InitializeXPosition2:     
  LDA (BLUEPILL_RAM+3)
  CMP xpos 
  BEQ r_SkipFall
  LDA xpos
  STA (REDPILL_RAM+3)
  STA (REDPILL_RAM+3+4)
  JMP r_PillMove

InitializeYPosition2:     
  LDA (BLUEPILL_RAM+0)
  CMP #($44 - $10)
  BCC continue_inity2
  CMP #($44 + $10)
  BCS continue_inity2
  JMP SkipFall2
continue_inity2:
  LDA #$44
  STA (REDPILL_RAM+0)
  STA (REDPILL_RAM+0+4)
  JMP r_PillInitX

r_SkipFall: 
  JMP SkipFall2

AnimatePills2: 
  LDA REDPILL_RAM
  CMP #$C0
  BEQ r_DelaySpawn
  CMP #$F0
  BEQ r_DelaySpawn
DontDelay2:
  LDA REDPILL_RAM
  CMP #$F0
  BEQ InitializeYPosition2
r_PillInitX:
  LDA REDPILL_RAM
  CMP #$44
  BEQ InitializeXPosition2
r_PillMove:
  LDA REDPILL_RAM
  CLC
  ADC #$01
  STA REDPILL_RAM
  ADC #$08
  STA (REDPILL_RAM+4)
SkipFall2:
  RTS
  
r_DelaySpawn:
  JMP DelaySpawn2
  
animLegsLeft: 
  .db $30, $12, $30, $22

animLegsRight: 
  .db $31, $13, $31, $23 