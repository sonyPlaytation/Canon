/// @

#macro SAVEFILE "CANON.save"
#macro DEV (GM_build_type == "run")
#macro SPOTS part_particles_burst(global.menuSpotsPart,global.cam.get_x()+(GAME_W/2),global.cam.get_y()+(GAME_H/2),psMenuSpots)

roomsTilDoom = 3;
roomsBeenThrough = []
current_frame = 0

global.inputDisplay = true;
global.debug = false;

lostAsFuck = 0;

global.playerName = "???";
initDialogue()
initFlavorText()
initCharacters()

global.fightEnemies = [global.enemies.sand];
global.fightStarter = noone ;
global.fightBG = bgBattleDesert;

global.mX = 0;
global.mY = 0;

global.mute = 1;
global.masterVolume = 1;
global.sfxVolume = 1;
global.musicVolume = 1;
global.voiceVolume = 0.4;

global.musVol = global.musicVolume * global.masterVolume * global.mute;
global.sfxVol = global.sfxVolume * global.masterVolume * global.mute;
global.voiceVol = global.voiceVolume * global.masterVolume * global.mute;

menuDebounce = 0;
nowSaving = false;

//scribble constants
draw_set_text(fSmall,c_white,fa_center,fa_middle)
scribble_anim_wave(3,0.5,-0.05);
scribble_anim_shake(0.5,0.75);

//window_set_cursor(cr_none)

noSpawnRooms =
[
	rMenu,
	rBattle
]