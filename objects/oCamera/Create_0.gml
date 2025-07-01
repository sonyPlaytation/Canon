/// @

follow = oPlayer;

stanncam_init(GAME_W,GAME_H,RES_W,RES_H);
global.cam = new stanncam(follow.x,follow.y);
global.cam.follow = follow;
global.cam.smooth_draw = true;

alarm[0] = 1;

