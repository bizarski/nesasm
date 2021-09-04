
goto_PlayTrack1:
  JMP PlayTrack1
goto_PlayTrack2:
  JMP PlayTrack2
goto_PlayTrack3:
  JMP PlayTrack3
goto_PlayTrack4:
  JMP PlayTrack4
goto_PlayTrack5:
  JMP PlayTrack5
goto_PlayTrack6:
  JMP PlayTrack6
goto_PlayTrack7:
  JMP PlayTrack7
goto_PlayTrack8:
  JMP PlayTrack8
goto_PlayTrack9:
  JMP PlayTrack9
goto_PlayTrack10:
  JMP PlayTrack10
goto_PlayTrack11:
  JMP PlayTrack11
goto_PlayTrack12:
  JMP PlayTrack12
goto_PlayTrack13:
  JMP PlayTrack13
  
PlayTrack1:
  LDA #$01
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong1Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack2: 
  LDA #$02
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette2
  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone 

PlayTrack3: 
  LDA #$03
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong3Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack4: 
  LDA #$04
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette4
  JSR LoadSong4Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone 

PlayTrack5: 
  LDA #$05
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette5
  JSR LoadSong5Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack6: 
  LDA #$06
  STA playingSongNumber
  LDA heroZappa+0
  STA currentHero
  LDA heroZappa+1
  STA currentHeroBop
  JSR LoadPalette6
  JSR LoadSong6Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack7: 
  LDA #$07
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong7Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack8: 
  LDA #$08
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong8Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack9: 
  LDA #$09
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette9
  JSR LoadSong9Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack10: 
  LDA #$0A
  STA playingSongNumber
  LDA heroFreddy+0
  STA currentHero
  LDA heroFreddy+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong10Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack11: 
  LDA #$0B
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette11
  JSR LoadSong11Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone
  
PlayTrack12: 
  LDA #$0C
  STA playingSongNumber
  LDA heroSparx+0
  STA currentHero
  LDA heroSparx+1
  STA currentHeroBop
  JSR LoadPalette1
  JSR LoadSong12Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone

PlayTrack13: 
  LDA #$0D
  STA playingSongNumber
  LDA heroIvo+0
  STA currentHero
  LDA heroIvo+1
  STA currentHeroBop
  JSR LoadPalette13
  JSR LoadSong13Background
  JSR AS_StartPlayingCurrentTrack
  JMP GameEngineDone