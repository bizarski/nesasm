
sprites:
     ;vert tile attr 	   horiz
  .db $F0, $00, %00000001, $F0   ;spratz 0                            ;00
  .db $F0, $01, %00000001, $F0   ;spratz 1
  .db $F0, $10, %00000000, $F0   ;spratz 2
  .db $F0, $11, %00000000, $F0   ;spratz 3                  
  .db $F0, $20, %00000000, $F0   ;spratz 4                            ;10
  .db $F0, $21, %00000000, $F0   ;spratz 5
  .db $F0, $30, %00000000, $F0   ;spratz 6                            
  .db $F0, $31, %00000000, $F0   ;spratz 7
  
  .db $00, $80, %00000010, $18   ;arrow 0 							  ;20
  
  .db $F0, $2A, %00000011, $3E   ;bass 0                    
  .db $F0, $2B, %00000011, $46   ;bass 1                              
  .db $F0, $2C, %00000011, $4E   ;bass 2
  .db $F0, $3A, %00000011, $3E   ;bass 3      						  ;30
  .db $F0, $3B, %00000011, $46   ;bass 4                    
  .db $F0, $3C, %00000011, $4E   ;bass 5                              
  
  .db $F0, $04, %00000001, $F0   ;elmo
  .db $F0, $05, %00000001, $F0										  ;40
  .db $F0, $14, %00000000, $F0        
  .db $F0, $15, %00000000, $F0                                        
  .db $F0, $24, %00000000, $F0
  .db $F0, $25, %00000000, $F0										  ;50
  
  .db $F0, $0A, %00000011, $B3   ;guitar 0                  
  .db $F0, $0B, %00000011, $BB   ;guitar 1                            
  .db $F0, $0C, %00000011, $C3   ;guitar 2
  .db $F0, $1A, %00000011, $B3   ;guitar 3							  ;60
  .db $F0, $1B, %00000011, $BB   ;guitar 4                  
  .db $F0, $1C, %00000011, $C3   ;guitar 5                            
  
  .db $F0, $06, %00000000, $F0   ;aldo   
  .db $F0, $07, %00000000, $F0 										  ;70
  .db $F0, $16, %00000000, $F0       
  .db $F0, $17, %00000000, $F0                                        
  .db $F0, $26, %00000000, $F0   
  .db $F0, $27, %00000000, $F0 										  ;80
  
  .db $F0, $44, %00000010, $F0   ; guiness 
  .db $F0, $45, %00000010, $F0                                        
  .db $F0, $54, %00000000, $F0
  .db $F0, $55, %00000000, $F0										  ;90
  .db $F0, $64, %00000000, $F0
  .db $F0, $65, %00000000, $F0										  

  .db $F0, $48, %00000000, $F0   ; cymbals
  .db $F0, $49, %00000000, $F0										  ;A0
  .db $F0, $4A, %00000000, $F0
  .db $F0, $4B, %00000000, $F0										  
  
  .db $F0, $0E, %00000010, $F0	 ; inventory								  

pillsprites: 
  .db $F0, $5C, %00000011, $F0	 ; blue pill						  ;00			
  .db $F0, $6C, %00000011, $F0
  
  .db $F0, $5C, %00000010, $F0	 ; red pill						  	   
  .db $F0, $6C, %00000010, $F0