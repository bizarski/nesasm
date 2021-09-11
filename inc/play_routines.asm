PlayTrack1:
  LDA #$01
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong1Background
  JMP goto_FinishPlayTrack

PlayTrack2: 
  LDA #$02
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette2
  JSR LoadSong2Background
  JMP goto_FinishPlayTrack 

PlayTrack3: 
  LDA #$03
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong3Background
  JMP goto_FinishPlayTrack

PlayTrack4: 
  LDA #$04
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette4
  JSR LoadSong4Background
  JMP goto_FinishPlayTrack 

PlayTrack5: 
  LDA #$05
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette5
  JSR LoadSong5Background
  JMP goto_FinishPlayTrack

PlayTrack6: 
  LDA #$06
  STA playingSongNumber
  LDA heroZappa+0
  STA currentHero
  LDA heroZappa+1
  STA currentHeroBop
  JSR LoadSongPalette ; LoadPalette6
  JSR LoadSong6Background
  JMP goto_FinishPlayTrack

PlayTrack7: 
  LDA #$07
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong7Background
  JMP goto_FinishPlayTrack

PlayTrack8: 
  LDA #$08
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong8Background
  JMP goto_FinishPlayTrack

PlayTrack9: 
  LDA #$09
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette9
  JSR LoadSong9Background
  JMP goto_FinishPlayTrack

PlayTrack10: 
  LDA #$0A
  STA playingSongNumber
  LDA heroFreddy+0
  STA currentHero
  LDA heroFreddy+1
  STA currentHeroBop
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong10Background
  JMP goto_FinishPlayTrack

PlayTrack11: 
  LDA #$0B
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette11
  JSR LoadSong11Background
  JMP goto_FinishPlayTrack
  
PlayTrack12: 
  LDA #$0C
  STA playingSongNumber
  JSR LoadSparxHero
  JSR LoadSongPalette ; LoadPalette1
  JSR LoadSong12Background
  JMP goto_FinishPlayTrack

PlayTrack13: 
  LDA #$0D
  STA playingSongNumber
  LDA heroIvo+0
  STA currentHero
  LDA heroIvo+1
  STA currentHeroBop
  JSR LoadSongPalette ; LoadPalette13
  JSR LoadSong13Background
  JMP goto_FinishPlayTrack
  
  
LoadSparxHero: 
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  RTS 
  
songPalettesLB: 
  .db low(bgpalette9) ; menu 
  .db low(bgpalette), low(bgpalette2), low(bgpalette), low(bgpalette4)
  .db low(bgpalette5), low(bgpalette6), low(bgpalette), low(bgpalette)
  .db low(bgpalette9), low(bgpalette), low(bgpalette11), low(bgpalette)
  .db low(bgpalette13) 
  
songPalettesHB: 
  .db HIGH(bgpalette9) ; menu 
  .db HIGH(bgpalette), HIGH(bgpalette2), HIGH(bgpalette), HIGH(bgpalette4)
  .db HIGH(bgpalette5), HIGH(bgpalette6), HIGH(bgpalette), HIGH(bgpalette)
  .db HIGH(bgpalette9), HIGH(bgpalette), HIGH(bgpalette11), HIGH(bgpalette)
  .db HIGH(bgpalette13) 
  
