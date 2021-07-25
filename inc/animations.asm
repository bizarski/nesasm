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
  STA (SPRATZ_RAM+4*4+1)
  LDA animLegsRight, x
  STA (SPRATZ_RAM+4*4+1+4)
  LDA #$05 
  STA keyHoldTimeout
AnimateNothing: 
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

animLegsLeft: 
  .db $20, $12, $20, $22

animLegsRight: 
  .db $21, $13, $21, $23 