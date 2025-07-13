/// @

draw_set_color(#230F33)
draw_set_alpha(alpha)
draw_rectangle_color(global.cam.x-GAME_W,global.cam.y-GAME_H,global.cam.x+GAME_W,global.cam.y+GAME_H,#230F33,#230F33,#17002B,#17002B,false)
draw_set_alpha(1)
draw_set_color(c_white)

if alpha >= alphaTarg*0.9
{
	draw_sprite_stretched(sTextBox,1,24,24,w,h)
}

if h == targH
{
	draw_sprite_stretched(sTextBox, 0,textX, _y + padding, 100, 100)
	draw_text(textX, _y + (padding) + 50, global.party[0].name)

	
}