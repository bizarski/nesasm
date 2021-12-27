frameRateIs60   .rs 1
buttons1   		.rs 1  ; player 1 gamepad buttons, one bit per button
buttonlatch		.rs 1

pointerLo  		.rs 1   ; pointer variables are declared in RAM
pointerHi  		.rs 1   ; low byte first, high byte immediately after

tmp				.rs 1
xpos            .rs 1
counter         .rs 1

nextFrame       .rs 1
nextFrame3      .rs 1
frameTimeout    .rs 1
faceTimeout		.rs 1
hitBeatTimeout  .rs 1
bufferTimeout   .rs 1
animationClock  .rs 1

currentSong     .rs 1
currentHero     .rs 1
  
gameFlags       .rs 1  ; xxx11111
soundFlags      .rs 1  ; xxxxx111
completionFlags .rs 2  ; xxx11111 11111111

playerLives		.rs 1
playerScore     .rs 2
highScore       .rs 2
scoreLo         .rs 1
scoreHi			.rs 1

samplePointer   .rs 1

playingSongNumber .rs 1

arrowPosition     .rs 1
