/// @

#macro GAME_W 640
#macro GAME_H 360
#macro RES_W 1920
#macro RES_H 1080

follow = oPlayer;

stanncam_init(GAME_W,GAME_H,RES_W,RES_H);
global.cam = new stanncam(follow.x,follow.y);
global.cam.follow = follow;
global.cam.smooth_draw = true;

windowScale = 3;
//window_set_size(GAME_W*windowScale,GAME_H*windowScale);
alarm[0] = 1;

