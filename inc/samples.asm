
sampleKick: 
  .incbin "dmc/SMB3_bass.dmc"

sampleSnare: 
  .incbin "dmc/1SN00019.dmc"

sampleCowbell: 
  .incbin "dmc/GradiusII_$C140.dmc"
 
sampleHandDrum: 
  .incbin "dmc/Twinbee3_$C300.dmc"  
  
sampleKick3: 
  .incbin "dmc/Recca_$C000.dmc"
  
sampleSnare2: 
  .incbin "dmc/TecmoBowl_$E100.dmc"
  
sampleScratch: 
  .incbin "dmc/scratch1.dmc"
  
sampleScratch2: 
  .incbin "dmc/scratch2.dmc"

  
sampleHey: 
  .incbin "dmc/TMNT3_$E300.dmc"
  
dmc_sample_table:
  .db $0F,$00,(sampleKick-$C000)/64,$09
  .db $0F,$00,(sampleSnare-$C000)/64,$1F
  
  .db $0F,$00,(sampleCowbell-$C000)/64,$12
  .db $0F,$00,(sampleHandDrum-$C000)/64,$12
  
  .db $0F,$00,(sampleKick3-$C000)/64,$0F
  .db $0F,$00,(sampleSnare2-$C000)/64,$20
  
  .db $0F,$00,(sampleScratch-$C000)/64,$1D
  .db $0F,$00,(sampleScratch2-$C000)/64,$22
  
  .db $0F,$00,(sampleHey-$C000)/64,$3F