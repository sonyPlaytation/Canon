/// @

follow = noone;
stanncam_init(GAME_W,GAME_H,RES_W,RES_H);
global.cam = new stanncam(x,y);
global.cam.smooth_draw = true;
global.cam.bounds_w = 0;
global.cam.bounds_h = 0;

resWHalf = RES_W/2
resHHalf = RES_H/2

gameWHalf = GAME_W/2
gameHHalf = GAME_H/2

alarm[0] = 1;

bgx = 0;

drawNothing = false