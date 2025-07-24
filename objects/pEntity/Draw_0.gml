/// @

// Inherit the parent event
if drawShadow {draw_character_shadow()}

draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

if global.debug 
{
	if isEnemy
	{
		if doWander
		{ 
			draw_set_color(c_red); 
	
			var vdx = lengthdir_x(24,dir);
			var vdy = lengthdir_y(24,dir);
	
			draw_arrow(x,y,x + vdx, y + vdy,5)
		}
	
		draw_set_alpha(0.45)
	
		draw_sprite(sprite_index,0,homeX,homeY)
	
		draw_set_color(c_red)
		draw_circle(homeX,homeY,homeSize,true)
	
		draw_set_color(c_aqua)
		draw_circle(x,y,chaseRange,true)
	
		draw_set_alpha(1)
	}
	
	draw_set_color(c_black)
	draw_circle(x,y,6,false)
	draw_set_color(c_white)
	draw_circle(x,y,5,false)
	
	draw_set_color(c_lime)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)
	
	
}