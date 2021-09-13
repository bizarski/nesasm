
sampleKick: 
  .incbin "dmc/TMNT2_$C2C0.dmc"

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
  .db $0F,$00,(sampleKick-sampleKick+$B8)/64,$09
  .db $0F,$00,(sampleSnare-sampleKick+$B8)/64,$1F
  
  .db $0F,$00,(sampleCowbell-sampleKick+$B8)/64,$12
  .db $0F,$00,(sampleHandDrum-sampleKick+$B8)/64,$12
  
  .db $0F,$00,(sampleKick3-sampleKick+$B8)/64,$0D
  .db $0F,$00,(sampleSnare2-sampleKick+$B8)/64,$20
  
  .db $0F,$00,(sampleScratch-sampleKick+$B8)/64,$1D
  .db $0F,$00,(sampleScratch2-sampleKick+$B8)/64,$22
  
  .db $0F,$00,(sampleHey-sampleKick+$B8)/64,$3F