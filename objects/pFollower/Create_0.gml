/// @

event_inherited();

caughtUp = false;

stateFollow = function()
{
	if follow
	{
		var distOff = 2;
	
		if x <= oPlayer.posX[followDist] + distOff and x >= oPlayer.posX[followDist] - distOff
		and y <= oPlayer.posY[followDist] + distOff and y >= oPlayer.posY[followDist] - distOff
		{ caughtUp = true; }

		if !caughtUp
		{
			image_speed = 2
			x = approach(x, oPlayer.posX[followDist],walksp);
			y = approach(y, oPlayer.posY[followDist],walksp);
		}
		else
		{
			image_speed = oPlayer.sprSpd[followDist];
			x = oPlayer.posX[followDist];
			y = oPlayer.posY[followDist];
		}
		
		facing = oPlayer.face[followDist]
		going	= oPlayer.going
	
		animate()
	
		x = round(x);
		y = round(y);
	}
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

state = stateFollow;