banktable:              ; Write to this table to switch banks.
  .byte $02, $02, $03, $04, $05, $06, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E

otherbanks: 
  .byte $00, $01

trackNumberInBankTable:
  .byte $00, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00