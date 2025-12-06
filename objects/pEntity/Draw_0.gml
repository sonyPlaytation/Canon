/// @

// Inherit the parent event
drawCharacter();

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
}