/// @
// FLAGS

#macro SAVEFILE "CANON.save"
#macro SETTINGS global.settings
#macro DEV (GM_build_type == "run")
#macro SPOTS part_particles_burst(global.menuSpotsPart,global.cam.get_x()+(GAME_W/2),global.cam.get_y()+(GAME_H/2),psMenuSpots)
#macro TIME global.current_frame

global.settings = {
    
    video : {
        fullscreen : false,
    },
    
    sound : {
        mute : 1,
        masterVolume : 1,
        sfxVolume : 1,
        musicVolume : 1,
        voiceVolume : 0.4
    },
    
    other : { // other/gameplay
        textspeed : 0.6,
        inputDisplay : true,
        dashCooldown : true
    },
    
}

global.current_frame = 0;

roomsTilDoom = 3;
roomsBeenThrough = []

// system and menus
menuDebounce = 0;
nowSaving = false;

global.debug = false;
global.piratedCopy = true;
if "pirated" != true {global.piratedCopy = false;}

initDialogue()
initFlavorText()
initCharacters()

global.fightEnemies = [global.enemies.sand];
global.fightStarter = noone ;
global.fightBG = bgBattleDesert;

global.mX = 0;
global.mY = 0;

//scribble constants
draw_set_text(fSmall,c_white,fa_center,fa_middle)
scribble_anim_wave(3,0.5,-0.05);
scribble_anim_shake(0.5,0.75);

global.fInputNum = font_add_sprite_ext(sInputNums,"1234567890",true,0);

noSpawnRooms =
[
	rMenu,
	rBattle,
    gspl_test_room,
    prOffice
]

if DEV {
    roomList = asset_get_ids(asset_room);
    roomList = array_filter(roomList,function(element, index){
        
        return !array_contains(noSpawnRooms,element);
    })
    RoomLoader.DataInitArray(roomList)
    screeny = RoomLoader.Screenshot(rOffice);
    cursorPos = 0;
    listLength = array_length(roomList);
    listActive = false;
    upFrames = 0;
    downFrames = 0;
}
