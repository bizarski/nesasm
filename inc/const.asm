PPU_SETUP = %00011110

TRACK_1 = $3D
TRACK_2 = $45
TRACK_3 = $4D
TRACK_4 = $55
TRACK_5 = $5D
TRACK_6 = $65
TRACK_7 = $6D
TRACK_8 = $75
TRACK_9 = $7D
TRACK_10 = $85
TRACK_11 = $8D
TRACK_12 = $95
TRACK_13 = $9D

INIT_ADDRESS = $A999
PLAY_ADDRESS = $A99C
LOAD_ADDRESS_BANK_1 = $8D81
LOAD_ADDRESS_BANK_2 = $9A15
LOAD_ADDRESS_BANK_3 = $90D5
LOAD_ADDRESS_BANK_4 = $9189
LOAD_ADDRESS_BANK_5 = $86B2
LOAD_ADDRESS_BANK_6 = $9521
LOAD_ADDRESS_BANK_7 = $8F93
LOAD_ADDRESS_BANK_8 = $8728
LOAD_ADDRESS_BANK_9 = $9235
LOAD_ADDRESS_BANK_10 = $9667
LOAD_ADDRESS_BANK_11 = $9277

BTN_LEFT = %00000010
BTN_RIGHT = %00000001
BTN_UP = %00001000
BTN_DOWN = %00000100
BTN_START = %00010000
BTN_SELECT = %00100000
BTN_A = %01000000
BTN_B = %10000000

; game flags: 
HERO_HIT = %00000001

; sound flags: 
SAMPLE_PLAYED = %00000001
MUSIC_INITIALIZED = %00000010
SAMPLE_CHANGED = %00000100

SPRITE_SPR_Y = $A4
SPRITE_SPR_X = $80

SPRITE_ELM_X = $3D
SPRITE_ELM_Y = $99

SPRITE_ALDO_X = $B0
SPRITE_ALDO_Y = $87

SPRITE_GUIN_X = $5E
SPRITE_GUIN_Y = $7B

SPRITE_CYM_X = $80
SPRITE_CYM_Y = $76

SPRITE_BASS_Y = $9E
SPRITE_GUITAR_Y = $8D

SPRATZ_RAM = $0414
ARROW_RAM = $0434
ELMO_RAM = $0450
ALDO_RAM = $0480
GUINESS_RAM = $0498
CYMBALS_RAM = $04B0
BASS_RAM = $0438
GUITAR_RAM = $0468
INVENTORY_RAM = $04C0
IS_PLAYING_RAM = $0211
KICK_RAM = $0262
NOISE_RAM = $0267
PAUSE_RAM = $02A8
BLUEPILL_RAM = $0400
REDPILL_RAM = $0408
COIN_RAM = $0410
SCORE_RAM = $04C4
WOO_RAM = $04D0
UFO_RAM = $04E0

OPAQUE_X_LEFT = $46
OPAQUE_X_RIGHT = $BA

MENU_X_LIMIT_TOP = $3D
MENU_X_LIMIT_BOTTOM = $9D