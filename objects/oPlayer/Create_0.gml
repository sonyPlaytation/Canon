/// @

playerSetup();

global.cam.follow = id;

enum FACING
{
	RIGHT	= 0,
	UP		= 1,
	LEFT	= 2,
	DOWN	= 3
}

stateFree = function()
{
	mask_index = sNilsIdle;
	groundMove();
	interact();
	animate();
	
	if dashCharge == dashFrames and InputPressed(INPUT_VERB.DASH)
	{
		dashTime = dashReset;
		dashSpd = 6;
		dashCharge = 0
		state = stateDash;
	} else if dashCharge < dashFrames {dashCharge++}
	
}

anims = 
{
	idle : sNilsIdle,
	walk : {
		U : sNilsWalkU,	
		D : sNilsWalkD,	
		L : sNilsWalkL,	
		R : sNilsWalkR,	
	}
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

updateFollowers = function()
{
	// Follower position array
	if (x != xprevious or y != yprevious)
	{
		for (var i = followLength-1; i > 0 ; i--)
		{
			face[i] = face[i-1];
			posX[i] = posX[i-1];
			posY[i] = posY[i-1];	
			sprSpd[i] = sprSpd[i-1]
		}
		face[0] = facing;
		posX[0] = x;
		posY[0] = y;
		sprSpd[0] = image_speed;
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
	
	if hasControl
	{
		xinput = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
		yinput = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
	}
	
	going = (point_distance(0, 0, xinput, yinput) > 0);
	
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

stateDash = function()
{
	sprite_index = sNilsDash
	if dashTime > 0 { dashTime-- } else { dashSpd = lerp(dashSpd, 0, 0.1) }
	
	hsp = lengthdir_x(dashSpd,dir);
	vsp = lengthdir_y(dashSpd,dir);
	move_and_collide(hsp,vsp,colls);
	
	if dashSpd > 2.5 and place_meeting(x+hsp, y+vsp, colls) 
	{
		zsp = 4;
		state = stateCrash
		oSFX.battlehit = snHit7
		global.cam.shake_screen(5,3);	
	}
	
	if dashSpd <= 1 {state = stateFree}
	
}

stateCrash = function()
{
	
	hsp = lengthdir_x(dashSpd,dir-180);
	vsp = lengthdir_y(dashSpd,dir-180);
	move_and_collide(hsp,vsp,colls);
	dashSpd = lerp(dashSpd, 0, 0.1)
	
	zsp -= grv;
	z += zsp;
	
	if z + zsp <= 0 
	{
		zsp = 0;
		z = 0;
		state = stateFree
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

state = stateFree;