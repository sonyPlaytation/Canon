var lerpSpd = global.letterbox ? 0.15 : 0.2
letterBoxHTarg = global.letterbox ? 1 : -1;
letterBoxH = lerp(letterBoxH,letterBoxHTarg,lerpSpd)

draw_set_colour(c_black)
draw_rectangle(0, 0, GAME_W, TILE_SIZE*letterBoxH, false)
draw_rectangle(0, GAME_H, GAME_W, GAME_H - TILE_SIZE*letterBoxH, false)

if global.debug {
	
	draw_text(25,45,$"Camera Speed:{global.cam.spd}")
	display_write_all_specs()
}
	