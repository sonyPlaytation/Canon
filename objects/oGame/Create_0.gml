/// @

#macro SAVEFILE "CANON.save"

global.inputDisplay = true;
global.debug = false;
global.dev = true;

global.fightEnemies = [global.enemies.sand] 
global.fightStarter = noone 
global.fightBG = bgPlaceholder

global.mX = 0
global.mY = 0

menuDebounce = 0;

//scribble constants
draw_set_text(fSmall,c_white,fa_center,fa_middle)
scribble_anim_wave(3,0.5,-0.05);
scribble_anim_shake(0.5,0.75);

//window_set_cursor(cr_none)