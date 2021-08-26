
sampleKick: 
  .incbin "dmc/TMNT2_$C2C0.dmc"

sampleSnare: 
  .incbin "dmc/BuckyOHare_$FE00.dmc"

sampleCowbell: 
  .incbin "dmc/GradiusII_$C140.dmc"
  
sampleKick3: 
  .incbin "dmc/Recca_$C000.dmc"
  
sampleSnare2: 
  .incbin "dmc/TecmoBowl_$E100.dmc"
  
sampleScratch: 
  .incbin "dmc/TMNTTF_$CD40.dmc"
  
sampleScratch2: 
  .incbin "dmc/TMNTTF_$CA40.dmc"
 
sampleHandDrum: 
  .incbin "dmc/Twinbee3_$C300.dmc" 

sampleKick2: 
  .incbin "dmc/Werewolf_$FB00.dmc" 
  
sampleSnare3: 
  .incbin "dmc/Werewolf_$FBC0.dmc" 
  
sampleHey: 
  .incbin "dmc/TMNT3_$E300.dmc"
  
dmc_sample_table:
  .db $0F,$00,(sampleKick-$C000)/64,$05
  .db $0F,$00,(sampleSnare-$C000)/64,$15
  
  .db $0F,$00,(sampleCowbell-$C000)/64,$12
  .db $0F,$00,(sampleHandDrum-$C000)/64,$12
  
  .db $0F,$00,(sampleKick3-$C000)/64,$0F
  .db $0F,$00,(sampleSnare2-$C000)/64,$22
  
  .db $0F,$00,(sampleScratch-$C000)/64,$1D
  .db $0F,$00,(sampleScratch2-$C000)/64,$22
  
  .db $0F,$00,(sampleKick2-$C000)/64,$0A
  .db $0F,$00,(sampleSnare3-$C000)/64,$12
  
  .db $0F,$00,(sampleHey-$C000)/64,$3F