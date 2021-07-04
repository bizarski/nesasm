song_index_Hail20Discordia = 0
song_index_SysNons = 1
song_index_Fried20Brain = 2
song_index_High20Stakes = 3
song_index_ANOWOR2eEXE = 4
song_index_Red20Pilled = 5
song_index_Mother20People = 6
song_index_No20Relations = 7
song_index_Koosagoopagoop = 8
song_index_Loveshy = 9
song_index_Mustapha = 10

song_list:
  .dw _Hail20Discordia
  .dw _SysNons
  .dw _Fried20Brain
  .dw _High20Stakes
  .dw _ANOWOR2eEXE
  .dw _Red20Pilled
  .dw _Mother20People
  .dw _No20Relations
  .dw _Koosagoopagoop
  .dw _Loveshy
  .dw _Mustapha

instrument_list:
  .dw _main_0
  .dw _hihat_1
  .dw _noise_2
  .dw _basskick_3
  .dw _snare2dtriangle_4
  .dw _kick2dtriangle_5
  .dw _basskick2dhigh_6
  .dw _arp_7
  .dw _arp2d2_8
  .dw _arp2d3_9
  .dw _main2dshort_10
  .dw _main2dshort2dslide_11
  .dw _snare_12
  .dw _snare2d2_13
  .dw _kick2_14
  .dw _perc_15
  .dw _basskick2dx_16
  .dw _kick2dtriangle_17
  .dw _env2df_18
  .dw _env2dl2dd_19
  .dw _lead3_20
  .dw _env2dl_21
  .dw _kick3_22
  .dw _hihat2dopen_23
  .dw silent_24

_main_0:
  .db 5,7,9,11,ARP_TYPE_ABSOLUTE
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_hihat_1:
  .db 5,10,12,14,ARP_TYPE_ABSOLUTE
  .db 12,9,7,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_noise_2:
  .db 5,11,13,15,ARP_TYPE_ABSOLUTE
  .db 15,15,14,11,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_basskick_3:
  .db 5,7,9,11,ARP_TYPE_ABSOLUTE
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 12,7,0,ENV_STOP

_snare2dtriangle_4:
  .db 5,13,15,17,ARP_TYPE_ABSOLUTE
  .db 15,13,8,10,6,2,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 15,9,4,6,0,-5,ENV_STOP

_kick2dtriangle_5:
  .db 5,11,14,16,ARP_TYPE_ABSOLUTE
  .db 15,15,14,11,0,ENV_STOP
  .db 103,ENV_LOOP,11
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_basskick2dhigh_6:
  .db 5,7,9,11,ARP_TYPE_ABSOLUTE
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 0,-7,-12,0,ENV_STOP

_arp_7:
  .db 5,7,9,11,ARP_TYPE_FIXED
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 53,53,48,48,44,44,41,41,ENV_LOOP,13

_arp2d2_8:
  .db 5,7,9,11,ARP_TYPE_FIXED
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 55,55,51,51,46,46,43,43,ENV_LOOP,13

_arp2d3_9:
  .db 5,7,9,11,ARP_TYPE_FIXED
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 56,56,51,51,49,49,44,44,ENV_LOOP,13

_main2dshort_10:
  .db 5,13,15,17,ARP_TYPE_ABSOLUTE
  .db 15,15,15,15,15,15,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_main2dshort2dslide_11:
  .db 5,13,16,18,ARP_TYPE_ABSOLUTE
  .db 15,15,15,15,15,15,0,ENV_STOP
  .db 5,-5,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_snare_12:
  .db 5,16,18,20,ARP_TYPE_ABSOLUTE
  .db 15,13,11,9,12,9,8,6,2,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db -5,-2,1,ENV_STOP

_snare2d2_13:
  .db 5,13,16,18,ARP_TYPE_ABSOLUTE
  .db 15,15,10,13,9,5,0,ENV_STOP
  .db 40,ENV_LOOP,13
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_kick2_14:
  .db 5,11,14,16,ARP_TYPE_ABSOLUTE
  .db 15,15,8,0,0,ENV_STOP
  .db -23,ENV_LOOP,11
  .db 192,DUTY_ENV_STOP
  .db ENV_STOP

_perc_15:
  .db 5,11,13,15,ARP_TYPE_ABSOLUTE
  .db 13,12,7,9,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_basskick2dx_16:
  .db 5,7,9,11,ARP_TYPE_ABSOLUTE
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 24,12,0,ENV_STOP

_kick2dtriangle_17:
  .db 5,11,13,15,ARP_TYPE_ABSOLUTE
  .db 15,15,8,0,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 12,7,0,ENV_STOP

_env2df_18:
  .db 5,17,19,21,ARP_TYPE_ABSOLUTE
  .db 12,12,10,9,8,6,5,2,1,1,0,ENV_STOP
  .db 0,ENV_STOP
  .db 192,DUTY_ENV_STOP
  .db ENV_STOP

_env2dl2dd_19:
  .db 5,52,54,57,ARP_TYPE_ABSOLUTE
  .db 10,10,10,10,10,10,10,10,10,10,9,8,7,7,7,7,7,7,5,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,1,1,1,1,0,ENV_STOP
  .db 0,ENV_STOP
  .db 64,128,DUTY_ENV_STOP
  .db ENV_STOP

_lead3_20:
  .db 5,22,24,26,ARP_TYPE_ABSOLUTE
  .db 4,7,8,10,10,10,10,10,10,10,8,6,3,2,3,4,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db 12,7,0,ENV_STOP

_env2dl_21:
  .db 5,52,54,56,ARP_TYPE_ABSOLUTE
  .db 10,10,10,10,10,10,10,10,10,10,9,8,7,7,7,7,7,7,5,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,1,1,1,1,0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_kick3_22:
  .db 5,11,14,16,ARP_TYPE_ABSOLUTE
  .db 15,15,8,0,0,ENV_STOP
  .db 127,ENV_LOOP,11
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_hihat2dopen_23:
  .db 5,17,21,23,ARP_TYPE_ABSOLUTE
  .db 12,11,9,7,5,7,5,4,3,2,0,ENV_STOP
  .db 86,60,16,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

silent_24:
  .db 5,7,9,11,ARP_TYPE_ABSOLUTE
  .db 0,ENV_STOP
  .db 0,ENV_STOP
  .db 0,DUTY_ENV_STOP
  .db ENV_STOP

_Hail20Discordia:
  .db 44
  .db 5
  .db 79
  .db 4
  .dw _Hail20Discordia_square1
  .dw _Hail20Discordia_square2
  .dw _Hail20Discordia_triangle
  .dw _Hail20Discordia_noise
  .dw 0

_Hail20Discordia_square1:
_Hail20Discordia_square1_loop:
  .db CAL,low(_Hail20Discordia_square1_16),high(_Hail20Discordia_square1_16)
  .db CAL,low(_Hail20Discordia_square1_20),high(_Hail20Discordia_square1_20)
  .db CAL,low(_Hail20Discordia_square1_16),high(_Hail20Discordia_square1_16)
  .db CAL,low(_Hail20Discordia_square1_21),high(_Hail20Discordia_square1_21)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_8),high(_Hail20Discordia_square1_8)
  .db CAL,low(_Hail20Discordia_square1_9),high(_Hail20Discordia_square1_9)
  .db CAL,low(_Hail20Discordia_square1_8),high(_Hail20Discordia_square1_8)
  .db CAL,low(_Hail20Discordia_square1_9),high(_Hail20Discordia_square1_9)
  .db CAL,low(_Hail20Discordia_square1_2),high(_Hail20Discordia_square1_2)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_23),high(_Hail20Discordia_square1_23)
  .db CAL,low(_Hail20Discordia_square1_24),high(_Hail20Discordia_square1_24)
  .db CAL,low(_Hail20Discordia_square1_24),high(_Hail20Discordia_square1_24)
  .db CAL,low(_Hail20Discordia_square1_24),high(_Hail20Discordia_square1_24)
  .db CAL,low(_Hail20Discordia_square1_24),high(_Hail20Discordia_square1_24)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_22),high(_Hail20Discordia_square1_22)
  .db CAL,low(_Hail20Discordia_square1_22),high(_Hail20Discordia_square1_22)
  .db CAL,low(_Hail20Discordia_square1_18),high(_Hail20Discordia_square1_18)
  .db CAL,low(_Hail20Discordia_square1_18),high(_Hail20Discordia_square1_18)
  .db CAL,low(_Hail20Discordia_square1_18),high(_Hail20Discordia_square1_18)
  .db CAL,low(_Hail20Discordia_square1_18),high(_Hail20Discordia_square1_18)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_8),high(_Hail20Discordia_square1_8)
  .db CAL,low(_Hail20Discordia_square1_9),high(_Hail20Discordia_square1_9)
  .db CAL,low(_Hail20Discordia_square1_8),high(_Hail20Discordia_square1_8)
  .db CAL,low(_Hail20Discordia_square1_9),high(_Hail20Discordia_square1_9)
  .db CAL,low(_Hail20Discordia_square1_2),high(_Hail20Discordia_square1_2)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_4),high(_Hail20Discordia_square1_4)
  .db CAL,low(_Hail20Discordia_square1_3),high(_Hail20Discordia_square1_3)
  .db CAL,low(_Hail20Discordia_square1_3),high(_Hail20Discordia_square1_3)
  .db CAL,low(_Hail20Discordia_square1_5),high(_Hail20Discordia_square1_5)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_0),high(_Hail20Discordia_square1_0)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_1),high(_Hail20Discordia_square1_1)
  .db CAL,low(_Hail20Discordia_square1_13),high(_Hail20Discordia_square1_13)
  .db CAL,low(_Hail20Discordia_square1_14),high(_Hail20Discordia_square1_14)
  .db CAL,low(_Hail20Discordia_square1_15),high(_Hail20Discordia_square1_15)
  .db GOT
  .dw _Hail20Discordia_square1_loop

_Hail20Discordia_square2:
_Hail20Discordia_square2_loop:
  .db CAL,low(_Hail20Discordia_square2_16),high(_Hail20Discordia_square2_16)
  .db CAL,low(_Hail20Discordia_square2_17),high(_Hail20Discordia_square2_17)
  .db CAL,low(_Hail20Discordia_square2_16),high(_Hail20Discordia_square2_16)
  .db CAL,low(_Hail20Discordia_square2_18),high(_Hail20Discordia_square2_18)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_7),high(_Hail20Discordia_square2_7)
  .db CAL,low(_Hail20Discordia_square2_8),high(_Hail20Discordia_square2_8)
  .db CAL,low(_Hail20Discordia_square2_7),high(_Hail20Discordia_square2_7)
  .db CAL,low(_Hail20Discordia_square2_8),high(_Hail20Discordia_square2_8)
  .db CAL,low(_Hail20Discordia_square2_3),high(_Hail20Discordia_square2_3)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_22),high(_Hail20Discordia_square2_22)
  .db CAL,low(_Hail20Discordia_square2_25),high(_Hail20Discordia_square2_25)
  .db CAL,low(_Hail20Discordia_square2_25),high(_Hail20Discordia_square2_25)
  .db CAL,low(_Hail20Discordia_square2_25),high(_Hail20Discordia_square2_25)
  .db CAL,low(_Hail20Discordia_square2_25),high(_Hail20Discordia_square2_25)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_21),high(_Hail20Discordia_square2_21)
  .db CAL,low(_Hail20Discordia_square2_21),high(_Hail20Discordia_square2_21)
  .db CAL,low(_Hail20Discordia_square2_20),high(_Hail20Discordia_square2_20)
  .db CAL,low(_Hail20Discordia_square2_20),high(_Hail20Discordia_square2_20)
  .db CAL,low(_Hail20Discordia_square2_23),high(_Hail20Discordia_square2_23)
  .db CAL,low(_Hail20Discordia_square2_24),high(_Hail20Discordia_square2_24)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_12),high(_Hail20Discordia_square2_12)
  .db CAL,low(_Hail20Discordia_square2_13),high(_Hail20Discordia_square2_13)
  .db CAL,low(_Hail20Discordia_square2_7),high(_Hail20Discordia_square2_7)
  .db CAL,low(_Hail20Discordia_square2_8),high(_Hail20Discordia_square2_8)
  .db CAL,low(_Hail20Discordia_square2_7),high(_Hail20Discordia_square2_7)
  .db CAL,low(_Hail20Discordia_square2_8),high(_Hail20Discordia_square2_8)
  .db CAL,low(_Hail20Discordia_square2_3),high(_Hail20Discordia_square2_3)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_2),high(_Hail20Discordia_square2_2)
  .db CAL,low(_Hail20Discordia_square2_4),high(_Hail20Discordia_square2_4)
  .db CAL,low(_Hail20Discordia_square2_4),high(_Hail20Discordia_square2_4)
  .db CAL,low(_Hail20Discordia_square2_5),high(_Hail20Discordia_square2_5)
  .db CAL,low(_Hail20Discordia_square2_0),high(_Hail20Discordia_square2_0)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_12),high(_Hail20Discordia_square2_12)
  .db CAL,low(_Hail20Discordia_square2_13),high(_Hail20Discordia_square2_13)
  .db CAL,low(_Hail20Discordia_square2_1),high(_Hail20Discordia_square2_1)
  .db CAL,low(_Hail20Discordia_square2_10),high(_Hail20Discordia_square2_10)
  .db CAL,low(_Hail20Discordia_square2_14),high(_Hail20Discordia_square2_14)
  .db CAL,low(_Hail20Discordia_square2_15),high(_Hail20Discordia_square2_15)
  .db GOT
  .dw _Hail20Discordia_square2_loop

_Hail20Discordia_triangle:
_Hail20Discordia_triangle_loop:
  .db CAL,low(_Hail20Discordia_triangle_9),high(_Hail20Discordia_triangle_9)
  .db CAL,low(_Hail20Discordia_triangle_10),high(_Hail20Discordia_triangle_10)
  .db CAL,low(_Hail20Discordia_triangle_9),high(_Hail20Discordia_triangle_9)
  .db CAL,low(_Hail20Discordia_triangle_10),high(_Hail20Discordia_triangle_10)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_11),high(_Hail20Discordia_triangle_11)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_19),high(_Hail20Discordia_triangle_19)
  .db CAL,low(_Hail20Discordia_triangle_8),high(_Hail20Discordia_triangle_8)
  .db CAL,low(_Hail20Discordia_triangle_5),high(_Hail20Discordia_triangle_5)
  .db CAL,low(_Hail20Discordia_triangle_8),high(_Hail20Discordia_triangle_8)
  .db CAL,low(_Hail20Discordia_triangle_5),high(_Hail20Discordia_triangle_5)
  .db CAL,low(_Hail20Discordia_triangle_3),high(_Hail20Discordia_triangle_3)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_15),high(_Hail20Discordia_triangle_15)
  .db CAL,low(_Hail20Discordia_triangle_16),high(_Hail20Discordia_triangle_16)
  .db CAL,low(_Hail20Discordia_triangle_16),high(_Hail20Discordia_triangle_16)
  .db CAL,low(_Hail20Discordia_triangle_16),high(_Hail20Discordia_triangle_16)
  .db CAL,low(_Hail20Discordia_triangle_16),high(_Hail20Discordia_triangle_16)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_11),high(_Hail20Discordia_triangle_11)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_4),high(_Hail20Discordia_triangle_4)
  .db CAL,low(_Hail20Discordia_triangle_14),high(_Hail20Discordia_triangle_14)
  .db CAL,low(_Hail20Discordia_triangle_18),high(_Hail20Discordia_triangle_18)
  .db CAL,low(_Hail20Discordia_triangle_14),high(_Hail20Discordia_triangle_14)
  .db CAL,low(_Hail20Discordia_triangle_14),high(_Hail20Discordia_triangle_14)
  .db CAL,low(_Hail20Discordia_triangle_14),high(_Hail20Discordia_triangle_14)
  .db CAL,low(_Hail20Discordia_triangle_14),high(_Hail20Discordia_triangle_14)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_11),high(_Hail20Discordia_triangle_11)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_19),high(_Hail20Discordia_triangle_19)
  .db CAL,low(_Hail20Discordia_triangle_8),high(_Hail20Discordia_triangle_8)
  .db CAL,low(_Hail20Discordia_triangle_5),high(_Hail20Discordia_triangle_5)
  .db CAL,low(_Hail20Discordia_triangle_8),high(_Hail20Discordia_triangle_8)
  .db CAL,low(_Hail20Discordia_triangle_5),high(_Hail20Discordia_triangle_5)
  .db CAL,low(_Hail20Discordia_triangle_3),high(_Hail20Discordia_triangle_3)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_1),high(_Hail20Discordia_triangle_1)
  .db CAL,low(_Hail20Discordia_triangle_15),high(_Hail20Discordia_triangle_15)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_11),high(_Hail20Discordia_triangle_11)
  .db CAL,low(_Hail20Discordia_triangle_0),high(_Hail20Discordia_triangle_0)
  .db CAL,low(_Hail20Discordia_triangle_19),high(_Hail20Discordia_triangle_19)
  .db CAL,low(_Hail20Discordia_triangle_13),high(_Hail20Discordia_triangle_13)
  .db CAL,low(_Hail20Discordia_triangle_6),high(_Hail20Discordia_triangle_6)
  .db CAL,low(_Hail20Discordia_triangle_7),high(_Hail20Discordia_triangle_7)
  .db CAL,low(_Hail20Discordia_triangle_17),high(_Hail20Discordia_triangle_17)
  .db GOT
  .dw _Hail20Discordia_triangle_loop

_Hail20Discordia_noise:
_Hail20Discordia_noise_loop:
  .db CAL,low(_Hail20Discordia_noise_10),high(_Hail20Discordia_noise_10)
  .db CAL,low(_Hail20Discordia_noise_10),high(_Hail20Discordia_noise_10)
  .db CAL,low(_Hail20Discordia_noise_10),high(_Hail20Discordia_noise_10)
  .db CAL,low(_Hail20Discordia_noise_10),high(_Hail20Discordia_noise_10)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_1),high(_Hail20Discordia_noise_1)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_6),high(_Hail20Discordia_noise_6)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_18),high(_Hail20Discordia_noise_18)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_17),high(_Hail20Discordia_noise_17)
  .db CAL,low(_Hail20Discordia_noise_16),high(_Hail20Discordia_noise_16)
  .db CAL,low(_Hail20Discordia_noise_19),high(_Hail20Discordia_noise_19)
  .db CAL,low(_Hail20Discordia_noise_20),high(_Hail20Discordia_noise_20)
  .db CAL,low(_Hail20Discordia_noise_19),high(_Hail20Discordia_noise_19)
  .db CAL,low(_Hail20Discordia_noise_21),high(_Hail20Discordia_noise_21)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_1),high(_Hail20Discordia_noise_1)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_1),high(_Hail20Discordia_noise_1)
  .db CAL,low(_Hail20Discordia_noise_15),high(_Hail20Discordia_noise_15)
  .db CAL,low(_Hail20Discordia_noise_11),high(_Hail20Discordia_noise_11)
  .db CAL,low(_Hail20Discordia_noise_15),high(_Hail20Discordia_noise_15)
  .db CAL,low(_Hail20Discordia_noise_15),high(_Hail20Discordia_noise_15)
  .db CAL,low(_Hail20Discordia_noise_15),high(_Hail20Discordia_noise_15)
  .db CAL,low(_Hail20Discordia_noise_15),high(_Hail20Discordia_noise_15)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_1),high(_Hail20Discordia_noise_1)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_6),high(_Hail20Discordia_noise_6)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_5),high(_Hail20Discordia_noise_5)
  .db CAL,low(_Hail20Discordia_noise_18),high(_Hail20Discordia_noise_18)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_14),high(_Hail20Discordia_noise_14)
  .db CAL,low(_Hail20Discordia_noise_17),high(_Hail20Discordia_noise_17)
  .db CAL,low(_Hail20Discordia_noise_16),high(_Hail20Discordia_noise_16)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_1),high(_Hail20Discordia_noise_1)
  .db CAL,low(_Hail20Discordia_noise_0),high(_Hail20Discordia_noise_0)
  .db CAL,low(_Hail20Discordia_noise_6),high(_Hail20Discordia_noise_6)
  .db CAL,low(_Hail20Discordia_noise_23),high(_Hail20Discordia_noise_23)
  .db CAL,low(_Hail20Discordia_noise_22),high(_Hail20Discordia_noise_22)
  .db CAL,low(_Hail20Discordia_noise_8),high(_Hail20Discordia_noise_8)
  .db CAL,low(_Hail20Discordia_noise_9),high(_Hail20Discordia_noise_9)
  .db GOT
  .dw _Hail20Discordia_noise_loop

_Hail20Discordia_square1_0:
  .db STI,0,SL3,F2,STI,24,SL1,A0,STI,-1,SL3,F2,STI,24,SL1,A0,STI,-1
  .db SL3,F2,STI,24,SL1,A0,STI,-1,SL3,G2,STI,24,SL1,A0,STI,-1
  .db SL3,G2,STI,24,SL1,A0,STI,-1,SL3,G2,STI,24,SL1,A0,STI,-1
  .db SLF,GS2,STI,24,SL3,A0,STI,-1,SL4,GS2,STI,24,SL2,A0,STI,-1
  .db SL4,G2,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square1_1:
  .db STI,0,SL3,F2,STI,24,SL1,A0,STI,-1,SL3,F2,STI,24,SL1,A0,STI,-1
  .db SL3,F2,STI,24,SL1,A0,STI,-1,SL3,G2,STI,24,SL1,A0,STI,-1
  .db SL3,G2,STI,24,SL1,A0,STI,-1,SL3,G2,STI,24,SL1,A0,STI,-1
  .db SLF,GS2,STI,24,SL3,A0,STI,-1,SL4,AS2,STI,24,SL2,A0,STI,-1
  .db SL4,G2,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square1_2:
  .db STI,24,SLL,60,A0,STI,0,SLC,GS3
  .db RET

_Hail20Discordia_square1_3:
  .db STI,0,SL6,F4,SL2,G4,SL4,F4,F4,G4,GS4,SLC,AS4,STI,-1,SLL,36
  .db C5
  .db RET

_Hail20Discordia_square1_4:
  .db STI,0,SLC,GS3,AS3,C4,SLL,36,CS3
  .db RET

_Hail20Discordia_square1_5:
  .db STI,0,SL2,CS4,STI,-1,CS4,CS4,DS4,DS4,DS4,SL5,F4,STI,24
  .db SLL,55,A0
  .db RET

_Hail20Discordia_square1_8:
  .db STI,0,SLL,36,F2,G2
  .db RET

_Hail20Discordia_square1_9:
  .db STI,0,SL1,DS3,STI,-1,SLB,0,STI,0,SLL,24,GS2,SL6,AS2,SLL,30
  .db C3
  .db RET

_Hail20Discordia_square1_13:
  .db STI,0,SL3,GS2,STI,24,SL1,A0,STI,-1,SL3,GS2,STI,24,SL1,A0
  .db STI,-1,SL3,GS2,STI,24,SL1,A0,STI,-1,SL3,AS2,STI,24,SL1,A0
  .db STI,-1,SL3,AS2,STI,24,SL1,A0,STI,-1,SL3,AS2,STI,24,SL1,A0
  .db STI,0,SL3,B2,STI,24,SL1,A0,STI,-1,SL3,B2,STI,24,SL1,A0,STI,-1
  .db SL3,B2,STI,24,SL1,A0,STI,-1,SL3,CS3,STI,24,SL1,A0,STI,-1
  .db SL3,CS3,STI,24,SL1,A0,STI,-1,SL3,CS3,STI,24,SL1,A0,STI,0
  .db SL3,D3,STI,24,SL1,A0,STI,-1,SL3,D3,STI,24,SL1,A0,STI,-1
  .db SL3,D3,STI,24,SL1,A0,STI,-1,SL3,E3,STI,24,SL1,A0,STI,-1
  .db SL3,E3,STI,24,SL1,A0,STI,-1,SL3,E3,STI,24,SL1,A0
  .db RET

_Hail20Discordia_square1_14:
  .db STI,0,SL2,F3,C3,GS2,C3,GS2,F2,C2,F2,GS2,C3,F3,GS3,SLE,G3
  .db STI,24,SLL,34,A0
  .db RET

_Hail20Discordia_square1_15:
  .db STI,24,SLL,72,A0
  .db RET

_Hail20Discordia_square1_16:
  .db STI,0,SL4,C4,SL2,B3,D4,C4,STI,24,A0,STI,0,A3,STI,24,A0,STI,0
  .db F3,STI,24,A0,STI,0,C4,STI,24,A0,STI,0,SL8,F4,SL4,AS3,SL2
  .db A3,C4,AS3,STI,24,A0,STI,0,G3,STI,24,A0,STI,0,E3,STI,24
  .db A0,STI,0,AS3,STI,24,A0,STI,0,SL0,E4
  .db RET

_Hail20Discordia_square1_18:
  .db STI,0,SL1,GS3,STI,-1,F3,CS3,GS3,F3,CS3,GS3,F3,CS3,GS3,F3
  .db CS3,GS3,F3,CS3,GS3,F3,CS3,GS3,F3,CS3,GS3,F3,CS3,GS3,F3,CS3
  .db GS3,F3,CS3,GS3,F3,CS3,GS3,F3,CS3,G3,DS3,C3,G3,DS3,C3,G3,DS3
  .db C3,G3,DS3,C3,G3,DS3,C3,G3,DS3,C3,SL3,DS3,C3,G3,DS3,C4,G3
  .db RET

_Hail20Discordia_square1_20:
  .db STI,0,SL2,AS2,C3,D3,STI,24,A0,STI,0,D3,E3,F3,STI,24,A0,STI,0
  .db A3,G3,F3,STI,24,A0,STI,0,SL8,C4,SL2,G3,A3,AS3,C4,SL4,D4,E4
  .db SL8,C4,SL0,C5
  .db RET

_Hail20Discordia_square1_21:
  .db STI,0,SL4,F4,SL2,E4,F4,SL4,E4,SL2,D4,E4,SL4,D4,SL2,AS3,D4
  .db SL4,C4,SL2,A3,C4,G3,A3,AS3,C4,SL4,D4,E4,SL8,C4,SL0,C5
  .db RET

_Hail20Discordia_square1_22:
  .db STI,0,SL3,GS2,STI,24,A0,STI,0,SL2,GS2,GS2,GS2,SL3,GS2,STI,24
  .db A0,STI,0,GS2,STI,24,A0,STI,0,SL2,GS2,GS2,GS2,SL3,GS2,STI,24
  .db A0,STI,0,DS2,STI,24,A0,STI,0,SL2,DS2,DS2,DS2,SL3,DS2,STI,24
  .db A0,STI,0,G2,STI,24,A0,STI,0,SL2,G2,G2,G2,SL3,G2,STI,24
  .db A0
  .db RET

_Hail20Discordia_square1_23:
  .db STI,0,SL2,CS3,STI,-1,CS3,CS3,DS3,DS3,DS3,SL5,F3,STI,24
  .db SLL,55,A0
  .db RET

_Hail20Discordia_square1_24:
  .db STI,0,SL3,C3,STI,24,A0,STI,0,SL2,C3,C3,C3,SL3,D3,STI,24
  .db A0,STI,0,SL2,D3,D3,D3,SL3,DS3,STI,24,A0,STI,0,SL2,DS3,DS3
  .db DS3,CS3,CS3,CS3,DS3,DS3,SLL,26,DS3
  .db RET

_Hail20Discordia_square2_0:
  .db STI,0,SL3,C3,STI,24,SL1,A0,STI,-1,SL3,C3,STI,24,SL1,A0,STI,-1
  .db SL3,C3,STI,24,SL1,A0,STI,-1,SL3,D3,STI,24,SL1,A0,STI,-1
  .db SL3,D3,STI,24,SL1,A0,STI,-1,SL3,D3,STI,24,SL1,A0,STI,-1
  .db SLF,DS3,STI,24,SL3,A0,STI,-1,SL4,DS3,STI,24,SL2,A0,STI,-1
  .db SL4,D3,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square2_1:
  .db STI,0,SL3,C3,STI,24,SL1,A0,STI,-1,SL3,C3,STI,24,SL1,A0,STI,-1
  .db SL3,C3,STI,24,SL1,A0,STI,-1,SL3,D3,STI,24,SL1,A0,STI,-1
  .db SL3,D3,STI,24,SL1,A0,STI,-1,SL3,D3,STI,24,SL1,A0,STI,-1
  .db SLF,DS3,STI,24,SL3,A0,STI,-1,SL4,F3,STI,24,SL2,A0,STI,-1
  .db SL4,D3,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square2_2:
  .db STI,0,SLC,F3,G3,GS3,SLL,36,F3
  .db RET

_Hail20Discordia_square2_3:
  .db STI,24,SLL,60,A0,STI,0,SLC,F3
  .db RET

_Hail20Discordia_square2_4:
  .db STI,7,SLC,F3,STI,8,G3,STI,9,GS3,STI,7,SLL,36,F3
  .db RET

_Hail20Discordia_square2_5:
  .db STI,0,SL2,F4,STI,-1,F4,F4,G4,G4,G4,SL5,GS4,STI,24,SLL,55
  .db A0
  .db RET

_Hail20Discordia_square2_7:
  .db STI,0,SLL,36,DS3,F3
  .db RET

_Hail20Discordia_square2_8:
  .db STI,0,SLC,AS3,SLL,24,DS3,SL6,F3,SLL,30,G3
  .db RET

_Hail20Discordia_square2_10:
  .db STI,0,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,DS3,STI,24,SL1,A0
  .db STI,-1,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0
  .db STI,-1,SL3,F3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0,STI,0
  .db SL3,FS3,STI,24,SL1,A0,STI,-1,SL3,FS3,STI,24,SL1,A0,STI,-1
  .db SL3,FS3,STI,24,SL1,A0,STI,-1,SL3,GS3,STI,24,SL1,A0,STI,-1
  .db SL3,GS3,STI,24,SL1,A0,STI,-1,SL3,GS3,STI,24,SL1,A0,STI,0
  .db SL3,A3,STI,24,SL1,A0,STI,-1,SL3,A3,STI,24,SL1,A0,STI,-1
  .db SL3,A3,STI,24,SL1,A0,STI,-1,SL3,B3,STI,24,SL1,A0,STI,-1
  .db SL3,B3,STI,24,SL1,A0,STI,-1,SL3,B3,STI,24,SL1,A0
  .db RET

_Hail20Discordia_square2_12:
  .db STI,0,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,DS3,STI,24,SL1,A0
  .db STI,-1,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0
  .db STI,-1,SL3,F3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0,STI,-1
  .db SLF,G3,STI,24,SL3,A0,STI,-1,SL4,G3,STI,24,SL2,A0,STI,-1
  .db SL4,F3,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square2_13:
  .db STI,0,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,DS3,STI,24,SL1,A0
  .db STI,-1,SL3,DS3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0
  .db STI,-1,SL3,F3,STI,24,SL1,A0,STI,-1,SL3,F3,STI,24,SL1,A0,STI,-1
  .db SLF,G3,STI,24,SL3,A0,STI,-1,SL4,GS3,STI,24,SL2,A0,STI,-1
  .db SL4,F3,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_square2_14:
  .db STI,0,SL2,C4,GS3,F3,GS3,F3,C3,GS2,C3,F3,GS3,C4,F4,SLE,E4
  .db STI,24,SLL,34,A0
  .db RET

_Hail20Discordia_square2_15:
  .db STI,24,SLL,72,A0
  .db RET

_Hail20Discordia_square2_16:
  .db STI,0,SL4,A3,SL2,G3,AS3,A3,STI,24,A0,STI,0,F3,STI,24
  .db A0,STI,0,C3,STI,24,A0,STI,0,F3,STI,24,A0,STI,0,SL8,A3,SL4
  .db G3,SL2,F3,A3,G3,STI,24,A0,STI,0,E3,STI,24,A0,STI,0,C3,STI,24
  .db A0,STI,0,G3,STI,24,A0,STI,0,SL0,C4
  .db RET

_Hail20Discordia_square2_17:
  .db STI,0,SL2,AS3,A3,F3,STI,24,A0,STI,0,AS3,A3,F3,STI,24
  .db A0,STI,0,AS3,A3,F3,STI,24,A0,STI,0,SL8,C4,SL2,F4,E4,D4,E4
  .db SL4,AS3,G3,SL8,E3,SL0,C3
  .db RET

_Hail20Discordia_square2_18:
  .db STI,0,SL4,D4,SL2,AS3,D4,SL4,C4,SL2,AS3,C4,SL4,AS3,SL2,G3
  .db AS3,SL4,A3,SL2,F3,A3,F4,E4,D4,E4,SL4,AS3,G3,SL8,E3,SL0,C3
  .db RET

_Hail20Discordia_square2_20:
  .db STI,0,SLL,18,G3,SLC,F3,STI,-1,SL6,G3,STI,0,SLL,18,F3,STI,-1
  .db DS3
  .db RET

_Hail20Discordia_square2_21:
  .db STI,0,SL3,DS3,STI,24,A0,STI,-1,SL2,DS3,DS3,DS3,SL3,DS3,STI,24
  .db A0,STI,-1,G3,STI,24,A0,STI,-1,SL2,G3,G3,G3,SL3,G3,STI,24
  .db A0,STI,0,C3,STI,24,A0,STI,0,SL2,C3,C3,C3,SL3,C3,STI,24
  .db A0,STI,0,DS3,STI,24,A0,STI,0,SL2,DS3,DS3,DS3,SL3,DS3,STI,24
  .db A0
  .db RET

_Hail20Discordia_square2_22:
  .db STI,0,SL2,F3,STI,-1,F3,F3,G3,G3,G3,SL5,GS3,STI,24,SLL,55
  .db A0
  .db RET

_Hail20Discordia_square2_23:
  .db STI,0,SL6,F2,GS2,F2,CS3,F3,CS3,SLL,36,C3
  .db RET

_Hail20Discordia_square2_24:
  .db STI,0,SL3,CS4,STI,-1,GS3,F3,CS4,GS3,F3,SL6,CS4,DS4,F4,SLF
  .db G4,SL1,DS4,D4,CS4,SLL,18,C4
  .db RET

_Hail20Discordia_square2_25:
  .db STI,0,SL3,F2,STI,24,A0,STI,-1,SL2,F2,F2,F2,SL3,G2,STI,24
  .db A0,STI,-1,SL2,G2,G2,G2,SL3,GS2,STI,24,A0,STI,-1,SL2,GS2
  .db GS2,GS2,F2,F2,F2,G2,G2,SLL,26,G2
  .db RET

_Hail20Discordia_triangle_0:
  .db STI,3,SL3,GS2,STI,24,SL1,A0,STI,0,SL3,F2,STI,24,SL1,A0,STI,0
  .db SL3,F2,STI,24,SL1,A0,STI,3,SL3,AS2,STI,24,SL1,A0,STI,0
  .db SL3,G2,STI,24,SL1,A0,STI,0,SL3,AS2,STI,24,SL1,A0,STI,3
  .db SLF,GS2,STI,24,SL3,A0,STI,3,SL4,GS2,STI,24,SL2,A0,STI,3
  .db SL4,G2,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_triangle_1:
  .db STI,3,SL6,F2,SL2,F2,SL4,F3,SL6,DS3,SL2,DS3,SL4,DS2,GS2,STI,0
  .db GS3,STI,3,GS2,SL2,CS2,STI,0,CS3,STI,-1,CS2,CS3,SLL,28
  .db CS2
  .db RET

_Hail20Discordia_triangle_3:
  .db STI,5,SL4,B3,STI,6,SL1,F4,STI,24,SL3,A0,STI,6,SL1,F4,STI,24
  .db SL3,A0,STI,6,SL1,F4,STI,24,SL3,A0,STI,6,SL1,C4,STI,24
  .db SL3,A0,STI,6,SL1,C4,STI,24,SL3,A0,STI,6,SL1,A3,STI,24
  .db SL3,A0,STI,5,SL4,B3,B3,STI,4,SL1,GS3,STI,24,SL3,A0,STI,4
  .db SL1,GS3,STI,24,SL3,A0,STI,4,SL1,GS3,STI,24,SL3,A0,STI,4
  .db SL1,GS3,STI,24,SL3,A0,STI,4,SL1,GS3,STI,24,SL3,A0,STI,4
  .db SL1,GS3,STI,24,SL3,A0,STI,4,SL1,GS3,STI,24,SLB,A0
  .db RET

_Hail20Discordia_triangle_4:
  .db STI,3,SL3,GS2,STI,24,SL1,A0,STI,0,SL3,F2,STI,24,SL1,A0,STI,0
  .db SL3,F2,STI,24,SL1,A0,STI,3,SL3,AS2,STI,24,SL1,A0,STI,0
  .db SL3,G2,STI,24,SL1,A0,STI,0,SL3,C3,STI,24,SLL,49,A0
  .db RET

_Hail20Discordia_triangle_5:
  .db STI,3,SLL,18,F2,SL6,F2,SLC,F2,F2,F2,F2
  .db RET

_Hail20Discordia_triangle_6:
  .db STI,6,SL3,GS3,STI,24,SL1,A0,STI,0,SL3,GS3,STI,24,SL1,A0,STI,0
  .db SL3,GS3,STI,24,SL1,A0,STI,3,SL3,GS2,STI,24,SL1,A0,STI,0
  .db SL3,GS2,STI,24,SL1,A0,STI,0,SL3,GS2,STI,24,SL1,A0,STI,6
  .db SL3,B3,STI,24,SL1,A0,STI,0,SL3,B3,STI,24,SL1,A0,STI,0
  .db SL3,B3,STI,24,SL1,A0,STI,3,SL3,B2,STI,24,SL1,A0,STI,0
  .db SL3,B2,STI,24,SL1,A0,STI,0,SL3,B2,STI,24,SL1,A0,STI,6
  .db SL3,D4,STI,24,SL1,A0,STI,0,SL3,D4,STI,24,SL1,A0,STI,0
  .db SL3,D4,STI,24,SL1,A0,STI,6,SL3,E4,STI,24,SL1,A0,STI,0
  .db SL3,E4,STI,24,SL1,A0,STI,0,SL3,E4,STI,24,SL1,A0
  .db RET

_Hail20Discordia_triangle_7:
  .db STI,3,SLL,24,F2,STI,24,SLL,48,A0
  .db RET

_Hail20Discordia_triangle_8:
  .db STI,3,SLL,18,F2,SL6,F2,SLC,F2,SLL,18,F2,SL6,F2,SLC,F2
  .db RET

_Hail20Discordia_triangle_9:
  .db STI,0,SL1,F4,STI,24,SL3,A0,STI,0,SL1,F5,STI,24,SL3,A0,STI,0
  .db SL1,F4,STI,24,SL3,A0,STI,0,SL1,F5,STI,24,SL3,A0,STI,0
  .db SL1,F4,STI,24,SL3,A0,STI,0,SL1,F5,STI,24,SL3,A0,STI,0
  .db SL1,F4,STI,24,SL3,A0,STI,0,SL1,F5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SLB,A0
  .db RET

_Hail20Discordia_triangle_10:
  .db STI,0,SL1,AS3,STI,24,SL3,A0,STI,0,SL1,AS4,STI,24,SL3,A0,STI,0
  .db SL1,AS3,STI,24,SL3,A0,STI,0,SL1,AS4,STI,24,SL3,A0,STI,0
  .db SL1,AS3,STI,24,SL3,A0,STI,0,SL1,AS4,STI,24,SL3,A0,STI,0
  .db SL1,AS3,STI,24,SL3,A0,STI,0,SL1,AS4,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SL3,A0,STI,0
  .db SL1,C4,STI,24,SL3,A0,STI,0,SL1,C5,STI,24,SLB,A0
  .db RET

_Hail20Discordia_triangle_11:
  .db STI,3,SL3,GS2,STI,24,SL1,A0,STI,0,SL3,F2,STI,24,SL1,A0,STI,0
  .db SL3,F2,STI,24,SL1,A0,STI,3,SL3,AS2,STI,24,SL1,A0,STI,0
  .db SL3,G2,STI,24,SL1,A0,STI,0,SL3,AS2,STI,24,SL1,A0,STI,3
  .db SLF,GS2,STI,24,SL3,A0,STI,3,SL4,AS2,STI,24,SL2,A0,STI,3
  .db SL4,G2,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_triangle_13:
  .db STI,6,SL3,F3,STI,24,SL1,A0,STI,0,SL3,F3,STI,24,SL1,A0,STI,0
  .db SL3,F3,STI,24,SL1,A0,STI,3,SL3,F2,STI,24,SL1,A0,STI,0
  .db SL3,F2,STI,24,SL1,A0,STI,0,SLL,52,F2
  .db RET

_Hail20Discordia_triangle_14:
  .db STI,3,SL3,CS3,STI,24,A0,STI,3,SL2,CS3,STI,-1,CS3,CS3,SL3
  .db CS3,STI,24,A0,STI,-1,CS3,STI,24,A0,STI,-1,SL2,CS3,CS3,CS3
  .db SL3,CS3,STI,24,A0,STI,-1,C3,STI,24,A0,STI,-1,SL2,C3,C3,C3
  .db SL3,C3,STI,24,A0,STI,-1,C3,STI,24,A0,STI,-1,SL2,C3,C3,C3
  .db SL3,C3,STI,24,A0
  .db RET

_Hail20Discordia_triangle_15:
  .db STI,3,SL2,CS2,STI,0,CS3,STI,-1,CS2,STI,3,DS3,STI,0,DS2,STI,-1
  .db DS3,STI,3,SL5,F3,STI,24,SLL,55,A0
  .db RET

_Hail20Discordia_triangle_16:
  .db STI,3,SL3,F2,STI,24,A0,STI,-1,SL2,F2,F2,F2,SL3,G2,STI,24
  .db A0,STI,-1,SL2,G2,G2,G2,SL3,GS2,STI,24,A0,STI,-1,SL2,GS2
  .db GS2,GS2,CS2,CS2,CS2,G2,G2,SLL,26,G2
  .db RET

_Hail20Discordia_triangle_17:
  .db STI,24,SLL,72,A0
  .db RET

_Hail20Discordia_triangle_18:
  .db STI,3,SL3,CS3,STI,24,A0,STI,3,SL2,CS3,STI,-1,CS3,CS3,SL3
  .db CS3,STI,24,A0,STI,-1,CS3,STI,24,A0,STI,-1,SL2,CS3,CS3,CS3
  .db SL3,CS3,STI,24,A0,STI,-1,C3,STI,24,A0,STI,-1,SL2,C3,C3,C3
  .db SL3,C3,STI,24,A0,STI,-1,C3,STI,24,A0,STI,-1,SL2,C3,C3,C3
  .db STI,4,CS4,CS4,CS4
  .db RET

_Hail20Discordia_triangle_19:
  .db STI,3,SL3,GS2,STI,24,SL1,A0,STI,0,SL3,F2,STI,24,SL1,A0,STI,0
  .db SL3,F2,STI,24,SL1,A0,STI,3,SL3,AS2,STI,24,SL1,A0,STI,0
  .db SL3,G2,STI,24,SL1,A0,STI,0,SL3,AS2,STI,24,SL1,A0,STI,3
  .db SLF,GS2,STI,24,SL3,A0,STI,3,SL4,AS2,STI,24,SL2,A0,STI,3
  .db SL4,G2,STI,24,SL8,A0,STI,4,SL6,B4,SL3,B4,B4
  .db RET

_Hail20Discordia_noise_0:
  .db STI,2,SL4,6,4,3,4,3,2,STI,0,SLL,17,13,STI,24,SL1,A0,STI,2
  .db SL6,13,STI,1,SLL,24,13
  .db RET

_Hail20Discordia_noise_1:
  .db STI,2,SL4,6,4,3,4,3,2,STI,0,SL6,13,STI,2,SL3,5,6,SL5,7,STI,24
  .db SL1,A0,STI,2,SL6,13,SL4,13,STI,24,SLL,20,A0
  .db RET

_Hail20Discordia_noise_5:
  .db STI,2,SL6,3,SL3,3,3,SL6,3,SL3,3,3,SL6,3,5,3,SL3,3,3,SL6
  .db 3,SL3,3,3,SL6,3,5
  .db RET

_Hail20Discordia_noise_6:
  .db STI,2,SL4,6,4,3,4,3,2,STI,0,SL6,13,STI,2,SL3,5,6,SL5,7,STI,24
  .db SL1,A0,STI,2,SL6,13,SL4,13,STI,24,SL2,A0,STI,1,SL3,14,14
  .db STI,2,SL6,10,SL3,10,10
  .db RET

_Hail20Discordia_noise_8:
  .db STI,0,SLL,20,4,STI,24,SL4,A0,STI,0,SLC,8,STI,7,SL3,9,STI,24
  .db SLL,33,A0
  .db RET

_Hail20Discordia_noise_9:
  .db STI,24,SLL,72,A0
  .db RET

_Hail20Discordia_noise_10:
  .db STI,2,SL4,0,3,0,SL2,3,0,SL4,0,3,0,3,0,3,0,3,SL2,0,0,3,0,SL4
  .db 0,SLC,3
  .db RET

_Hail20Discordia_noise_11:
  .db STI,2,SL3,0,5,SL2,0,0,SL5,0,STI,1,SL3,14,STI,2,0,5,SL2,0,0
  .db 0,SL3,0,STI,1,14,STI,2,0,5,SL2,0,0,0,SL3,0,STI,1,14,STI,2
  .db SL2,0,5,0,5,5,5,5,5,5
  .db RET

_Hail20Discordia_noise_14:
  .db STI,1,SL2,0,14,14,STI,2,0,4,STI,1,14,STI,2,0,STI,1,14,STI,2
  .db 0,0,4,STI,1,14,0,14,14,STI,2,0,4,STI,1,14,STI,2,0,STI,1
  .db 14,STI,2,0,0,4,STI,1,SLL,26,14
  .db RET

_Hail20Discordia_noise_15:
  .db STI,0,SL3,4,STI,2,5,SL2,0,0,SL5,0,STI,1,SL3,14,STI,2,0,5,SL2
  .db 0,0,0,SL3,0,STI,1,14,STI,2,0,5,SL2,0,0,0,SL3,0,STI,1,14,STI,2
  .db 0,5,SL2,0,0,0,SL3,0,STI,1,14
  .db RET

_Hail20Discordia_noise_16:
  .db STI,1,SL2,4,14,14,STI,2,4,STI,1,14,14,SLL,60,0
  .db RET

_Hail20Discordia_noise_17:
  .db STI,1,SL2,0,14,14,STI,2,0,4,STI,1,14,STI,2,0,STI,1,14,STI,2
  .db 0,0,4,STI,1,14,0,14,14,STI,2,0,4,STI,1,SLL,38,14
  .db RET

_Hail20Discordia_noise_18:
  .db STI,2,SL4,13,SL2,5,STI,24,A0,STI,2,SL4,5,5,4,4,2,0,0,4,SL2
  .db 4,STI,24,A0,STI,2,SL4,4,4,4,4,SLC,4
  .db RET

_Hail20Discordia_noise_19:
  .db STI,0,SL2,11,STI,1,14,14,STI,2,0,0,0,0,STI,1,14,14,STI,2
  .db 0,0,0,0,STI,1,14,14,STI,2,0,0,0,0,4,0,4,0,SLL,26,4
  .db RET

_Hail20Discordia_noise_20:
  .db STI,2,SL2,0,STI,1,14,14,STI,2,0,0,0,0,STI,1,14,4,STI,2
  .db 0,0,0,0,STI,1,14,14,STI,2,0,0,0,10,4,STI,0,0,STI,2,6,SLL,28
  .db 3
  .db RET

_Hail20Discordia_noise_21:
  .db STI,2,SL2,0,STI,1,14,14,STI,2,0,0,0,0,STI,1,14,14,STI,2
  .db 0,4,SLL,50,10
  .db RET

_Hail20Discordia_noise_22:
  .db STI,2,SL4,6,4,3,4,3,2,6,4,3,4,3,2,6,4,3,4,3,2
  .db RET

_Hail20Discordia_noise_23:
  .db STI,0,SL4,8,13,STI,2,5,0,0,SLL,52,0
  .db RET

_SysNons:
  .db 0
  .db 5
  .db 42
  .db 4
  .dw _SysNons_square1
  .dw _SysNons_square2
  .dw _SysNons_triangle
  .dw _SysNons_noise
  .dw 0

_SysNons_square1:
_SysNons_square1_loop:
  .db CAL,low(_SysNons_square1_7),high(_SysNons_square1_7)
  .db CAL,low(_SysNons_square1_7),high(_SysNons_square1_7)
  .db CAL,low(_SysNons_square1_9),high(_SysNons_square1_9)
  .db CAL,low(_SysNons_square1_9),high(_SysNons_square1_9)
  .db CAL,low(_SysNons_square1_0),high(_SysNons_square1_0)
  .db CAL,low(_SysNons_square1_0),high(_SysNons_square1_0)
  .db CAL,low(_SysNons_square1_1),high(_SysNons_square1_1)
  .db CAL,low(_SysNons_square1_2),high(_SysNons_square1_2)
  .db CAL,low(_SysNons_square1_2),high(_SysNons_square1_2)
  .db CAL,low(_SysNons_square1_1),high(_SysNons_square1_1)
  .db CAL,low(_SysNons_square1_3),high(_SysNons_square1_3)
  .db CAL,low(_SysNons_square1_4),high(_SysNons_square1_4)
  .db CAL,low(_SysNons_square1_5),high(_SysNons_square1_5)
  .db CAL,low(_SysNons_square1_4),high(_SysNons_square1_4)
  .db CAL,low(_SysNons_square1_5),high(_SysNons_square1_5)
  .db CAL,low(_SysNons_square1_6),high(_SysNons_square1_6)
  .db CAL,low(_SysNons_square1_6),high(_SysNons_square1_6)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_11),high(_SysNons_square1_11)
  .db CAL,low(_SysNons_square1_12),high(_SysNons_square1_12)
  .db CAL,low(_SysNons_square1_9),high(_SysNons_square1_9)
  .db CAL,low(_SysNons_square1_9),high(_SysNons_square1_9)
  .db CAL,low(_SysNons_square1_0),high(_SysNons_square1_0)
  .db CAL,low(_SysNons_square1_0),high(_SysNons_square1_0)
  .db CAL,low(_SysNons_square1_1),high(_SysNons_square1_1)
  .db CAL,low(_SysNons_square1_2),high(_SysNons_square1_2)
  .db CAL,low(_SysNons_square1_2),high(_SysNons_square1_2)
  .db CAL,low(_SysNons_square1_1),high(_SysNons_square1_1)
  .db CAL,low(_SysNons_square1_3),high(_SysNons_square1_3)
  .db CAL,low(_SysNons_square1_4),high(_SysNons_square1_4)
  .db CAL,low(_SysNons_square1_5),high(_SysNons_square1_5)
  .db CAL,low(_SysNons_square1_4),high(_SysNons_square1_4)
  .db CAL,low(_SysNons_square1_5),high(_SysNons_square1_5)
  .db CAL,low(_SysNons_square1_6),high(_SysNons_square1_6)
  .db CAL,low(_SysNons_square1_6),high(_SysNons_square1_6)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_10),high(_SysNons_square1_10)
  .db CAL,low(_SysNons_square1_13),high(_SysNons_square1_13)
  .db GOT
  .dw _SysNons_square1_loop

_SysNons_square2:
_SysNons_square2_loop:
  .db CAL,low(_SysNons_square2_5),high(_SysNons_square2_5)
  .db CAL,low(_SysNons_square2_5),high(_SysNons_square2_5)
  .db CAL,low(_SysNons_square2_6),high(_SysNons_square2_6)
  .db CAL,low(_SysNons_square2_6),high(_SysNons_square2_6)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_1),high(_SysNons_square2_1)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_1),high(_SysNons_square2_1)
  .db CAL,low(_SysNons_square2_2),high(_SysNons_square2_2)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_4),high(_SysNons_square2_4)
  .db CAL,low(_SysNons_square2_4),high(_SysNons_square2_4)
  .db CAL,low(_SysNons_square2_7),high(_SysNons_square2_7)
  .db CAL,low(_SysNons_square2_7),high(_SysNons_square2_7)
  .db CAL,low(_SysNons_square2_8),high(_SysNons_square2_8)
  .db CAL,low(_SysNons_square2_9),high(_SysNons_square2_9)
  .db CAL,low(_SysNons_square2_10),high(_SysNons_square2_10)
  .db CAL,low(_SysNons_square2_12),high(_SysNons_square2_12)
  .db CAL,low(_SysNons_square2_6),high(_SysNons_square2_6)
  .db CAL,low(_SysNons_square2_6),high(_SysNons_square2_6)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_1),high(_SysNons_square2_1)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_0),high(_SysNons_square2_0)
  .db CAL,low(_SysNons_square2_1),high(_SysNons_square2_1)
  .db CAL,low(_SysNons_square2_2),high(_SysNons_square2_2)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_3),high(_SysNons_square2_3)
  .db CAL,low(_SysNons_square2_4),high(_SysNons_square2_4)
  .db CAL,low(_SysNons_square2_4),high(_SysNons_square2_4)
  .db CAL,low(_SysNons_square2_7),high(_SysNons_square2_7)
  .db CAL,low(_SysNons_square2_7),high(_SysNons_square2_7)
  .db CAL,low(_SysNons_square2_8),high(_SysNons_square2_8)
  .db CAL,low(_SysNons_square2_9),high(_SysNons_square2_9)
  .db CAL,low(_SysNons_square2_11),high(_SysNons_square2_11)
  .db GOT
  .dw _SysNons_square2_loop

_SysNons_triangle:
_SysNons_triangle_loop:
  .db CAL,low(_SysNons_triangle_5),high(_SysNons_triangle_5)
  .db CAL,low(_SysNons_triangle_5),high(_SysNons_triangle_5)
  .db CAL,low(_SysNons_triangle_6),high(_SysNons_triangle_6)
  .db CAL,low(_SysNons_triangle_6),high(_SysNons_triangle_6)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_1),high(_SysNons_triangle_1)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_1),high(_SysNons_triangle_1)
  .db CAL,low(_SysNons_triangle_2),high(_SysNons_triangle_2)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_4),high(_SysNons_triangle_4)
  .db CAL,low(_SysNons_triangle_4),high(_SysNons_triangle_4)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_8),high(_SysNons_triangle_8)
  .db CAL,low(_SysNons_triangle_6),high(_SysNons_triangle_6)
  .db CAL,low(_SysNons_triangle_6),high(_SysNons_triangle_6)
  .db CAL,low(_SysNons_triangle_6),high(_SysNons_triangle_6)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_1),high(_SysNons_triangle_1)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_0),high(_SysNons_triangle_0)
  .db CAL,low(_SysNons_triangle_1),high(_SysNons_triangle_1)
  .db CAL,low(_SysNons_triangle_2),high(_SysNons_triangle_2)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_3),high(_SysNons_triangle_3)
  .db CAL,low(_SysNons_triangle_4),high(_SysNons_triangle_4)
  .db CAL,low(_SysNons_triangle_4),high(_SysNons_triangle_4)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_7),high(_SysNons_triangle_7)
  .db CAL,low(_SysNons_triangle_9),high(_SysNons_triangle_9)
  .db GOT
  .dw _SysNons_triangle_loop

_SysNons_noise:
_SysNons_noise_loop:
  .db CAL,low(_SysNons_noise_5),high(_SysNons_noise_5)
  .db CAL,low(_SysNons_noise_5),high(_SysNons_noise_5)
  .db CAL,low(_SysNons_noise_6),high(_SysNons_noise_6)
  .db CAL,low(_SysNons_noise_6),high(_SysNons_noise_6)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_1),high(_SysNons_noise_1)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_1),high(_SysNons_noise_1)
  .db CAL,low(_SysNons_noise_2),high(_SysNons_noise_2)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_4),high(_SysNons_noise_4)
  .db CAL,low(_SysNons_noise_4),high(_SysNons_noise_4)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_8),high(_SysNons_noise_8)
  .db CAL,low(_SysNons_noise_11),high(_SysNons_noise_11)
  .db CAL,low(_SysNons_noise_6),high(_SysNons_noise_6)
  .db CAL,low(_SysNons_noise_6),high(_SysNons_noise_6)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_1),high(_SysNons_noise_1)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_0),high(_SysNons_noise_0)
  .db CAL,low(_SysNons_noise_1),high(_SysNons_noise_1)
  .db CAL,low(_SysNons_noise_2),high(_SysNons_noise_2)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_3),high(_SysNons_noise_3)
  .db CAL,low(_SysNons_noise_4),high(_SysNons_noise_4)
  .db CAL,low(_SysNons_noise_4),high(_SysNons_noise_4)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_7),high(_SysNons_noise_7)
  .db CAL,low(_SysNons_noise_9),high(_SysNons_noise_9)
  .db GOT
  .dw _SysNons_noise_loop

_SysNons_square1_0:
  .db STI,24,SL4,A0,STI,0,SL2,C3,STI,24,A0,STI,0,DS3,SL4,D3,SL2
  .db C3,SL8,FS3,SL7,C3,STI,24,SL5,A0,STI,0,SL3,C3,STI,24,SL1
  .db A0,STI,0,SL6,C3,SL1,D3,STI,24,A0,STI,0,SLC,D3,STI,24
  .db SL4,A0
  .db RET

_SysNons_square1_1:
  .db STI,0,SL2,C3,D3,STI,24,A0,STI,0,C3,D3,STI,24,A0,STI,0
  .db DS3,D3,STI,24,A0,STI,0,DS3,D3,STI,24,SLL,42,A0
  .db RET

_SysNons_square1_2:
  .db STI,24,SL4,A0,STI,0,SL2,C3,STI,24,A0,STI,0,DS3,SL4,D3,SL2
  .db C3,SL6,FS3,SL1,G3,A3,SL8,G3,SL3,C3,STI,24,SL1,A0,STI,0
  .db SL3,C3,STI,24,SL1,A0,STI,0,SL6,C3,SL1,D3,STI,24,A0,STI,0
  .db SLC,D3,STI,24,SL4,A0
  .db RET

_SysNons_square1_3:
  .db STI,0,SL2,DS3,D3,STI,24,A0,STI,0,DS3,D3,STI,24,A0,STI,0
  .db DS3,D3,STI,24,A0,STI,0,DS3,D3,STI,24,A0,STI,0,DS3,D3,STI,24
  .db A0,STI,0,DS3,D3,STI,24,SLL,30,A0
  .db RET

_SysNons_square1_4:
  .db STI,0,SL0,D4,AS3,G3,FS3
  .db RET

_SysNons_square1_5:
  .db STI,0,SL0,D4,G3,DS4,FS3
  .db RET

_SysNons_square1_6:
  .db STI,0,SLL,27,G3,STI,24,SL1,A0,STI,0,AS2,STI,24,A0,STI,0
  .db DS3,STI,24,A0,STI,0,SLF,FS3,STI,24,SL1,A0,STI,0,A3,STI,24
  .db A0,STI,0,A3,STI,24,A0,STI,0,SL2,AS3,STI,24,SLA,A0
  .db RET

_SysNons_square1_7:
  .db STI,24,SLL,64,A0
  .db RET

_SysNons_square1_9:
  .db STI,11,SL2,D4,STI,-1,D4,D4,D4,D4,D4,C4,C4,B3,B3,B3,B3,B3
  .db B3,A3,A3,G3,G3,G3,G3,G3,G3,A3,A3,G3,G3,G3,G3,B3,B3,G3,G3
  .db RET

_SysNons_square1_10:
  .db STI,0,SL1,G3,STI,24,A0,STI,0,AS3,STI,24,A0,STI,0,G3,STI,24
  .db A0,STI,0,DS3,STI,24,A0,STI,0,D3,STI,24,A0,STI,0,AS2,STI,24
  .db A0,STI,0,D3,STI,24,A0,STI,0,G3,STI,24,A0,STI,0,AS3,STI,24
  .db A0,STI,0,G3,STI,24,A0,STI,0,DS3,STI,24,A0,STI,0,D3,STI,24
  .db A0,STI,0,AS2,STI,24,A0,STI,0,D3,STI,24,A0,STI,0,G3,STI,24
  .db A0,STI,0,AS3,STI,24,A0,STI,0,G3,STI,24,A0,STI,0,DS3,STI,24
  .db A0,STI,0,D3,STI,24,A0,STI,0,AS2,STI,24,A0,STI,0,D3,STI,24
  .db A0,STI,0,G3,STI,24,A0,STI,0,AS3,STI,24,A0,STI,0,G3,STI,24
  .db A0,STI,0,DS3,STI,24,A0,STI,0,D3,STI,24,A0,STI,0,AS2,STI,24
  .db A0,STI,0,D3,STI,24,SL9,A0
  .db RET

_SysNons_square1_11:
  .db STI,0,SLL,32,D3,SLL,26,C3,STI,24,SL6,A0
  .db RET

_SysNons_square1_12:
  .db STI,24,SLL,64,A0
  .db RET

_SysNons_square1_13:
  .db STI,0,SLL,36,D3,STI,24,SLL,28,A0
  .db RET

_SysNons_square2_0:
  .db STI,24,SLL,64,A0
  .db RET

_SysNons_square2_1:
  .db STI,24,SLL,64,A0
  .db RET

_SysNons_square2_2:
  .db STI,24,SLC,A0,STI,0,SL2,G3,FS3,STI,24,A0,STI,0,G3,FS3,STI,24
  .db A0,STI,0,AS3,A3,STI,24,A0,STI,0,AS3,A3,STI,24,SLL,30
  .db A0
  .db RET

_SysNons_square2_3:
  .db STI,24,SL4,A0,STI,0,SL2,G3,STI,24,A0,STI,10,AS3,STI,0
  .db AS3,STI,24,A0,STI,0,D4,STI,24,SL4,A0,STI,0,SL2,DS3,STI,24
  .db A0,STI,10,G3,STI,0,G3,STI,24,A0,STI,0,AS3,STI,24,SL4,A0,STI,0
  .db SL2,C3,STI,24,A0,STI,10,DS3,STI,0,DS3,STI,24,A0,STI,0
  .db D3,STI,24,SL4,A0,STI,0,SL2,D3,STI,24,A0,STI,10,FS3,STI,0
  .db FS3,STI,24,A0,STI,0,A3
  .db RET

_SysNons_square2_4:
  .db STI,0,SL4,D3,STI,24,SL2,A0,STI,0,SL1,C3,STI,24,A0,STI,0
  .db SL7,C3,STI,24,A0,STI,0,SL1,C3,STI,24,A0,STI,0,C3,STI,24
  .db A0,STI,0,D3,STI,24,A0,STI,0,DS3,STI,24,A0,STI,0,FS3,STI,24
  .db A0,STI,0,SL4,DS3,STI,24,SL2,A0,STI,0,SL1,D3,STI,24,A0,STI,0
  .db SL7,D3,STI,24,SLL,17,A0
  .db RET

_SysNons_square2_5:
  .db STI,10,SL2,G1,STI,-1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1
  .db G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2,G1,G2
  .db RET

_SysNons_square2_6:
  .db STI,10,SL1,G3,STI,24,A0,STI,-1,G3,STI,24,A0,STI,-1,D4,STI,24
  .db A0,STI,-1,G4,STI,24,A0,STI,-1,B4,STI,24,A0,STI,-1,B4,STI,24
  .db A0,STI,-1,G4,STI,24,A0,STI,-1,D4,STI,24,A0,STI,-1,G3,STI,24
  .db A0,STI,-1,D4,STI,24,A0,STI,-1,B4,STI,24,A0,STI,-1,G4,STI,24
  .db A0,STI,-1,G3,STI,24,A0,STI,-1,G3,STI,24,A0,STI,-1,G4,STI,24
  .db A0,STI,-1,B4,STI,24,A0,STI,-1,G3,STI,24,A0,STI,-1,G3,STI,24
  .db A0,STI,-1,D4,STI,24,A0,STI,-1,G4,STI,24,A0,STI,-1,B4,STI,24
  .db A0,STI,-1,B4,STI,24,A0,STI,-1,G4,STI,24,A0,STI,-1,D4,STI,24
  .db A0,STI,-1,G3,STI,24,A0,STI,-1,D4,STI,24,A0,STI,-1,B4,STI,24
  .db A0,STI,-1,G4,STI,24,A0,STI,-1,G3,STI,24,A0,STI,-1,G3,STI,24
  .db A0,STI,-1,G4,STI,24,A0,STI,-1,B4,STI,24,A0
  .db RET

_SysNons_square2_7:
  .db STI,0,SLE,G2,AS2,SLL,22,A2,SL2,G3,G2,SLA,G3
  .db RET

_SysNons_square2_8:
  .db STI,0,SLE,G2,D3,SLL,22,C3,SL2,DS3,D3,SLA,DS3
  .db RET

_SysNons_square2_9:
  .db STI,0,SLE,G3,SL8,A3,SL6,F3,SLL,22,DS3,SL2,AS3,C4,SLA,D4
  .db RET

_SysNons_square2_10:
  .db STI,0,SLL,32,AS2,SLL,26,A2,SL2,AS3,C4,D4
  .db RET

_SysNons_square2_11:
  .db STI,0,SLL,36,AS2,STI,24,SLL,28,A0
  .db RET

_SysNons_square2_12:
  .db STI,11,SL2,G3,STI,-1,D3,SL4,G3,SL2,G3,D3,SL4,G3,SL2,G3,D3
  .db SL4,G3,B3,SLL,36,G3
  .db RET

_SysNons_triangle_0:
  .db STI,10,SL2,C3,STI,-1,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3
  .db C3,C3,C3,C3,C3,C3,C3,D3,D3,D3,D3,D3,D3,D3,D3,D3,D3,DS3,STI,24
  .db A0
  .db RET

_SysNons_triangle_1:
  .db STI,0,SL2,A2,STI,-1,D2,STI,24,A0,STI,-1,A2,D2,STI,24
  .db A0,STI,-1,DS2,D2,STI,24,A0,STI,-1,DS2,D2,STI,24,SLL,42
  .db A0
  .db RET

_SysNons_triangle_2:
  .db STI,0,SL2,DS2,STI,-1,D2,STI,24,A0,STI,-1,DS2,D2,STI,24
  .db A0,STI,-1,DS2,D2,STI,24,A0,STI,-1,DS2,D2,STI,24,A0,STI,-1
  .db DS2,D2,STI,24,A0,STI,-1,DS2,D2,STI,24,SLL,30,A0
  .db RET

_SysNons_triangle_3:
  .db STI,10,SL2,G3,STI,-1,G3,G3,G3,G3,G3,AS3,G3,DS3,DS3,DS3,DS3
  .db DS3,DS3,G3,DS3,C3,C3,C3,C3,C3,C3,DS3,C3,D3,D3,D3,D3,D3,D3
  .db FS3,A3
  .db RET

_SysNons_triangle_4:
  .db STI,10,SL2,C3,STI,-1,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3
  .db C3,C3,C3,D3,D3,D3,D3,D3,D3,D3,D3,D3,D3,DS3,STI,24,SLA,A0
  .db RET

_SysNons_triangle_5:
  .db STI,10,SL2,G4,STI,-1,G4,D5,G5,B5,B5,G5,D5,G4,D5,B5,G5,G4
  .db G4,G5,B5,G4,G4,D5,G5,B5,B5,G5,D5,G4,D5,B5,G5,G4,G4,G5,B5
  .db RET

_SysNons_triangle_6:
  .db STI,10,SL2,G2,STI,-1,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2
  .db G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3,G2,G3
  .db RET

_SysNons_triangle_7:
  .db STI,10,SL4,G2,STI,0,SL2,G6,STI,24,A0,STI,10,G2,G2,A2,SL4
  .db G2,STI,0,SL2,G6,STI,24,A0,STI,10,G2,G2,A2,SL4,G2,STI,0
  .db SL2,G6,STI,24,A0,STI,10,G2,G2,A2,SL4,G2,STI,0,SL2,G6,STI,24
  .db A0,STI,10,G2,G2,SLA,A2
  .db RET

_SysNons_triangle_8:
  .db STI,0,SL0,G2,DS3,C3,D3
  .db RET

_SysNons_triangle_9:
  .db STI,0,SLL,36,G2,STI,24,SLL,28,A0
  .db RET

_SysNons_noise_0:
  .db STI,2,SL2,1,STI,1,14,14,14,STI,2,1,1,STI,1,14,14,STI,2
  .db 1,STI,1,14,14,14,STI,2,1,1,STI,1,14,14,STI,2,1,STI,1,14,STI,2
  .db 7,STI,1,14,STI,2,1,STI,1,14,14,14,STI,2,1,1,STI,1,14,14,STI,2
  .db 1,1,SL4,5
  .db RET

_SysNons_noise_1:
  .db STI,2,SL2,5,SL4,2,SL2,5,SL4,2,SL2,5,SL4,2,SL2,5,SLL,44
  .db 2
  .db RET

_SysNons_noise_2:
  .db STI,2,SL2,5,SL4,2,SL2,5,SL4,2,SL2,5,SL4,2,SL2,5,SL4,2,SL2
  .db 5,SL4,2,SL2,5,SLL,32,2
  .db RET

_SysNons_noise_3:
  .db STI,2,SL4,0,4,SL2,0,0,SL4,4,0,4,SL2,0,0,SL4,4,0,4,SL2,0,0
  .db SL4,4,SL2,0,0,4,STI,1,14,STI,2,SL4,0,4
  .db RET

_SysNons_noise_4:
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,0,SLC,7
  .db RET

_SysNons_noise_5:
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14,STI,2
  .db SL2,0,STI,1,SL1,14,14,STI,2,SL2,0,STI,1,SL1,14,14
  .db RET

_SysNons_noise_6:
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,STI,1,SL1,14,14
  .db STI,2,SL2,0,STI,1,SL1,14,14,STI,12,SL2,9,SL1,9,9
  .db RET

_SysNons_noise_7:
  .db STI,2,SL2,0,STI,1,14,STI,12,4,STI,1,14,STI,2,0,0,STI,12
  .db 4,STI,2,0,STI,1,14,STI,12,4,STI,1,14,STI,2,0,0,STI,12
  .db 4,STI,2,0,STI,1,14,STI,12,4,STI,1,14,STI,2,0,0,STI,12
  .db 4,STI,2,0,STI,1,14,STI,12,4,STI,1,14,STI,2,0,0,STI,12
  .db SLA,4
  .db RET

_SysNons_noise_8:
  .db STI,0,SLC,1,STI,24,SLL,46,A0,STI,1,SL1,4,3,4,3,4,3
  .db RET

_SysNons_noise_9:
  .db STI,0,SLC,1,STI,24,SLL,52,A0
  .db RET

_SysNons_noise_11:
  .db STI,0,SL3,4,STI,24,SLL,25,A0,STI,12,SL2,9,STI,1,SL1,14,SLL,33
  .db 14
  .db RET

_Fried20Brain:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_High20Stakes:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_ANOWOR2eEXE:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_Red20Pilled:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_Mother20People:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_No20Relations:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_Koosagoopagoop:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_Loveshy:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

_Mustapha:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw 0

