
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
  JSR LoadPalette1
  JSR LoadSong1Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack2: 
  LDA #$02
  STA playingSongNumber
  JSR LoadPalette2
  JSR LoadSong2Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed 

PlayTrack3: 
  LDA #$03
  STA playingSongNumber
  JSR LoadPalette3
  JSR LoadSong3Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack4: 
  LDA #$04
  STA playingSongNumber
  JSR LoadPalette4
  JSR LoadSong4Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed 

PlayTrack5: 
  LDA #$05
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong5Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack6: 
  LDA #$06
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong6Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack7: 
  LDA #$07
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong7Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack8: 
  LDA #$08
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong8Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack9: 
  LDA #$09
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong9Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack10: 
  LDA #$0A
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong10Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack11: 
  LDA #$0B
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong11Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed
  
PlayTrack12: 
  LDA #$0C
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong12Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed

PlayTrack13: 
  LDA #$0D
  STA playingSongNumber
  JSR LoadPalette5
  JSR LoadSong13Background
  JSR AS_StartPlayingCurrentTrack
  JMP FinishStartPressed