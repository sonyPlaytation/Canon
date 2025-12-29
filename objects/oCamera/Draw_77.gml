/// @


//draw_sprite_tiled_ext(bgSand,0,bgx,bgx,3,3,c_white,0.65)



if !drawNothing {global.cam.draw(0,0);}

var lerpSpd = global.letterbox ? 0.15 : 0.2
letterBoxHTarg = global.letterbox ? 4 : -1;
letterBoxH = lerp(letterBoxH,letterBoxHTarg,lerpSpd)

draw_set_colour(c_black)
draw_rectangle(0, 0, RES_W, TILE_SIZE*letterBoxH, false)
draw_rectangle(0, RES_H, RES_W, RES_H - TILE_SIZE*letterBoxH, false)