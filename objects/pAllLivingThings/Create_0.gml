/// @

selfCenter = y - (sprite_height/2);

z = 0;
drawXScale = 1;
drawYScale = 1;
rot = 0;
color = c_white;
alpha = 1;
fogColor = c_white;
fogAlpha = 0;

going = false;
dir = 0;
facing = 0;

flagID = $"{room_get_name(room)}-{object_get_name(id.object_index)}-{x}-{y}"

anims = {};

stateInCutscene = function()
{

	going = (point_distance(xprevious, yprevious, x, y ) != 0)
	if going { dir = point_direction(xprevious, yprevious,x, y) }
	
	image_speed = clamp(point_distance(xprevious, yprevious, x, y )/2,0,3)
	
	facing = dir div 90;
	
	animate();	
	
}

animate = function()
{

	if !going 
	{
		sprite_index = anims.idle;
		image_index = facing;
	}
	else // walk anims
	{
		switch (facing)
		{
			case 0:
				if sprite_index != anims.walk.R {image_index = 0}
				sprite_index = anims.walk.R;
			break;
			
			case 1:
				if sprite_index != anims.walk.U {image_index = 0}
				sprite_index = anims.walk.U;
			break;
			
			case 2:
				if sprite_index != anims.walk.L {image_index = 0}
				sprite_index = anims.walk.L;
			break;
			
			case 3:
				if sprite_index != anims.walk.D {image_index = 0}
				sprite_index = anims.walk.D;
			break;
			
		}
	}
}
