/// @

//room_goto_next();

instance_create_depth(GAME_W/2,GAME_H/2,depth,oCamera);

if DEV {instance_create_depth(0,0,-9999,oConsole)}
global.fSF3Time = font_add_sprite_ext(sBattleTimer,"1234567890",false,2)

loadSettings()

audio_group_load(agText);
audio_group_load(agSFX);
