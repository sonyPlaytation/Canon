/// @

playerSetup();

hasControl = true;
going = 0;
facing = 1;

enum FACING
{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

stateFree = function()
{
	mask_index = sNils;
	groundMove();
	interact();
	animate();
}

interact = function()
{
	var actX = lengthdir_x(TILE_SIZE,dir);
	var actY = lengthdir_y(TILE_SIZE,dir);
	
	if collision_line(x,y,x + actX,y + actY,pEntity, false, false) and InputPressed(INPUT_VERB.ACTION)
	{
		var act = instance_nearest(x+actX,y+actY,pEntity);
		with act
		{ if myTopic != "" {startDialogue(myTopic)} }
	}
}

groundMove = function()
{
	var spdNow;
	if InputCheck(INPUT_VERB.RUN)
	{
		spdNow = runsp;
		image_speed = 1.5
	} 
	else 
	{
		spdNow = walksp
		image_speed = 1
	}
	
	var xinput = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
	var yinput = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
	going = (point_distance(0, 0, xinput, yinput) > 0);
	
	//if point_direction(0, 0, xinput, yinput) mod 90 != 0 
	//{
	//	if InputPressed(INPUT_VERB.RIGHT)	facing = 0;
	//	if InputPressed(INPUT_VERB.UP)		facing = 1;
	//	if InputPressed(INPUT_VERB.LEFT)	facing = 2;
	//	if InputPressed(INPUT_VERB.DOWN)	facing = 3;
	//}
	
	if going 
	{
		dir = point_direction(0, 0, xinput, yinput);
		facing = point_direction(0, 0, xinput, yinput) div 90
		spd = spdNow;
	}
	else
	{ spd = 0; }
	
	if diagFix or place_meeting(x+xinput,y+yinput,colls)
	{
		hsp = lengthdir_x(spd,dir);
		vsp = lengthdir_y(spd,dir);	
	}
	else
	{
		hsp = xinput*spd;
		vsp = yinput*spd;
	}
	
	move_and_collide(hsp,vsp,colls);
}

animate = function()
{
	
	if spd != 0
	{
		switch facing
		{
			case 3:
				sprite_index = sNilsWalkDown;
			break;
			
			default:
				sprite_index = sNils; image_index = facing;
			break;
		}
	} else {sprite_index = sNils; image_index = facing;}
	
	
}

state = stateFree;