/// @

#macro SAVEFILE "CANON.save"
#macro DEV (GM_build_type == "run")

global.inputDisplay = true;
global.debug = false;

global.fightEnemies = [global.enemies.sand];
global.fightStarter = noone ;
global.fightBG = bgBattleDesert;

global.mX = 0;
global.mY = 0;

global.mute = !DEV;
global.masterVolume = 1;
global.sfxVolume = 1;
global.musicVolume = 1;

global.musVol = global.musicVolume * global.masterVolume * global.mute;
global.sfxVol = global.sfxVolume * global.masterVolume * global.mute;

menuDebounce = 0;
nowSaving = false;

//scribble constants
draw_set_text(fSmall,c_white,fa_center,fa_middle)
scribble_anim_wave(3,0.5,-0.05);
scribble_anim_shake(0.5,0.75);

//window_set_cursor(cr_none)