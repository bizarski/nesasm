music           .rs 16

buttons1   		.rs 1  ; player 1 gamepad buttons, one bit per button
buttonlatch		.rs 1

pointerLo  		.rs 1   ; pointer variables are declared in RAM
pointerHi  		.rs 1   ; low byte first, high byte immediately after

nextFrame       .rs 1
frameTimeout    .rs 1

currentSong     .rs 1

isSongSpritesShown  .rs 1
isSampleBeingPlayed .rs 1  
isMusicInitialized  .rs 1
isSampleChanged     .rs 1 ; TODO: store 7 flags in one byte


keyHoldTimeout  .rs 1  ; frame counter: rolls over every 256 frames

samplePointer   .rs 1

playingSongNumber .rs 1