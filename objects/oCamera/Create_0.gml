/// @

overlays = [
    {
        tag: "darkRoom",
        obj : oDarkness
    },
    
    {
        tag: "sandstorm",
        obj : oSandstorm,
        func : function(){ if instance_exists(oSandstormScaler) oSandstorm.alpha = oSandstormScaler.startAlpha; }
    }
]

follow = noone;
stanncam_init(GAME_W,GAME_H,640,360);
global.cam = new stanncam(x,y);
global.cam.smooth_draw = true;
global.cam.bounds_w = 0;
global.cam.bounds_h = 0;
global.cam.room_constrain = true;
global.cam.spd = SETTINGS.video.camSpd+3

global.screenHalfX = global.cam.get_x()+(GAME_W/2)
global.screenHalfY = global.cam.get_y()+(GAME_H/2)

resWHalf = RES_W/2
resHHalf = RES_H/2

gameWHalf = GAME_W/2
gameHHalf = GAME_H/2

letterBoxH = 0
letterBoxHTarg = 4

alarm[0] = 1;

bgx = 0;

drawNothing = false