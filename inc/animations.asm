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
  LDA keyHoldTimeout
  BNE AnimateNothing
  LDY #$00
  LDX nextFrame
  LDA animLegsLeft, x
  STA SPRITE_SPR_LEGS
  LDA animLegsRight, x
  STA (SPRITE_SPR_LEGS+4)
  LDA #$05 
  STA keyHoldTimeout
AnimateNothing: 
  RTS 

SpritesBop: 
  LDA #$08 
  STA SPRITE_SPR_HEAD
  LDA #$09 
  STA (SPRITE_SPR_HEAD+4)
  LDA #$18
  STA (SPRITE_SPR_HEAD+4+4)
  LDA #$19
  STA (SPRITE_SPR_HEAD+4+4+4)
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
  LDA #$9E ; bass
  JSR MoveBass 
  LDA #$8D ; guitar
  JSR MoveGuitars
  RTS 

MoveGuitarsDown: 
  LDA #$9D ; bass
  JSR MoveBass 
  LDA #$8C ; guitar  
  JSR MoveGuitars
  RTS 

MoveGuitars: 
  STA SPRITE_GUITAR_ADDR
  STA (SPRITE_GUITAR_ADDR+4)
  STA (SPRITE_GUITAR_ADDR+4+4)
  CLC 
  ADC #$08
  STA (SPRITE_GUITAR_ADDR+8+4) 
  STA (SPRITE_GUITAR_ADDR+8+4+4)  
  STA (SPRITE_GUITAR_ADDR+8+4+4+4)   
  RTS 

MoveBass: 
  STA SPRITE_BASS_ADDR
  STA (SPRITE_BASS_ADDR+4)
  STA (SPRITE_BASS_ADDR+4+4)
  CLC 
  ADC #$08
  STA (SPRITE_BASS_ADDR+8+4)
  STA (SPRITE_BASS_ADDR+8+4+4) 
  STA (SPRITE_BASS_ADDR+8+4+4+4)    
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
  STA SPRITE_CYMB_ADDR
  CLC 
  ADC #$01 
  STA (SPRITE_CYMB_ADDR+4)
  CLC
  ADC #$01 
  STA (SPRITE_CYMB_ADDR+8)
  CLC
  ADC #$01 
  STA (SPRITE_CYMB_ADDR+12)
  RTS 

animLegsLeft: 
  .db $20, $12, $20, $22

animLegsRight: 
  .db $21, $13, $21, $23 