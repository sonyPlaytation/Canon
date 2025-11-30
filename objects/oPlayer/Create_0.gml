/// @

event_inherited()

playerSetup();

global.cam.move(x,y)

canDash = (FLAGS.canDash or DEV)
canRun = true;
colls = [oColl,oDashGap,pNPC,tiles];
followers = [];

cutMove = false;

//if !layer_exists("Particles") {layer_create(depth-1,"Particles")}
partLayer = part_system_create_layer("Instances", false);
partDash = psDashTrail;
partType = part_type_create();
partDashSys = part_system_create(partDash);
partDashEmit = part_emitter_create(partDashSys);

enum FACING
{
	RIGHT	= 0,
	UP		= 1,
	LEFT	= 2,
	DOWN	= 3
}

stateFree = function()
{
	colls = [oColl,oDashGap,pNPC,tiles];
	inPosition = false;
	
	mask_index = sNilsIdle;
	groundMove();
	interact();
	animate();
	
	if place_meeting(x,y,oDashGap){backToSolidGround()}
	
	if canDash and dashCharge == dashFrames
	{
        fogAlpha = approach(fogAlpha,0,0.15);
        if InputPressed(INPUT_VERB.DASH)
        {
			if FLAGS.act1.chargeTackle{
				fogAlpha = 1;
	            blinkExt(fogAlpha, "fogAlpha", 0, dashFrames)
	            SFX sn3sDash;
			}
            
            dashTime = dashReset;
            dashSpd = 6;
            dashCharge = 0
            state = stateDash;
        }
        
	} else if dashCharge < dashFrames 
    {
        dashCharge++
        if SETTINGS.other.dashCooldown and dashCharge == dashFrames {SFX sn3sRespawn; fogColor = c_yellow; fogAlpha = 0.25;}
            
    }
	
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
	var seeDist = TILE_SIZE
	if instance_exists(oDarkness) seeDist = TILE_SIZE/2;
	
	var actX = lengthdir_x(seeDist,dir);
	var actY = lengthdir_y(seeDist,dir);
	
	if collision_line(x, y, x+actX, y+actY, pEntity, false, false) and InputPressed(INPUT_VERB.ACTION)
	{
		var actors = ds_list_create()
		var act = collision_line_list(x,y,x+actX,y+actY,pEntity,false,false,actors,true);
		var actNow = ds_list_find_value(actors,0)
		
		if actNow != -1
		{
			with actNow
			{ 
				if struct_exists(anims,"idle")
				{
					sprite_index = anims.idle;
					facing = round(point_direction(x, y, other.x, other.y) / 90)
					if facing > 3 {facing = 0}
				}
				
				if shortMsg != "" {global.topics[$ "shortMessage"] = [TEXT(shortMsg)]}

				myScript(myTopic);
			}
		}
		ds_list_destroy(actors);
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
	if InputCheck(INPUT_VERB.RUN) and canRun
	{
		runsp = lerp(runsp, runspMax, 0.05)
		spdNow = runsp;
		image_speed = runsp/2
	} 
	else 
	{
		runsp = runspDefault
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
		facing = round(point_direction(0, 0, xinput, yinput) / 90)
		if facing > 3 {facing = 0}
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
	if FLAGS.act1.chargeTackle{
	    fogColor = c_yellow
	    if TIME mod 2 == 0 {part_particles_burst(partDashSys,x,y,partDash);} 
	}
	colls = [oColl,pNPC,tiles];
	
	var dx = lengthdir_x(TILE_SIZE*5.5,dir);
	var dy = lengthdir_y(TILE_SIZE*5.5,dir);
	
	sprite_index = sNilsDash

	if dashTime > 0 { dashTime-- } 
	else { dashSpd = lerp(dashSpd, 0, 0.1) }
	
	if FLAGS.act1.chargeTackle and place_meeting(x,y,oDashGap) and dashTime == 0 { dashTime = 1 } 
	
	hsp = lengthdir_x(dashSpd,dir);
	vsp = lengthdir_y(dashSpd,dir);
	move_and_collide(hsp,vsp,colls);
	
	if dashSpd > 2.5 and place_meeting(x+hsp, y+vsp, colls) 
	{
        SFX sn3sCrash;
		zsp = 4;
		state = stateCrash
		global.cam.shake_screen(5,3);	
	}
	
	if dashSpd <= 1 
	{
        fogAlpha = 0;
		if place_meeting(x,y,oDashGap)
		{
			backToSolidGround()
		}
		state = stateFree
	}
	
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
		if place_meeting(x,y,oDashGap)
		{
			backToSolidGround()
		}
		
		zsp = 0;
		z = 0;
		state = stateFree
	}
}

stateStartCutscene = function()
{
	dir = point_direction(x, y, gotoX, gotoY )
	going = (point_distance(x,y,gotoX,gotoY) >= 1);
	facing = dir div 90;
	
	animate();
		
	if point_distance(x,y,gotoX,gotoY) < 2 
	{
		x = gotoX;
		y = gotoY;
		inPosition = true;
	}
	else
	{
		hsp = lengthdir_x(walksp,dir);
		vsp = lengthdir_y(walksp,dir);	

		move_and_collide(hsp,vsp,[]);
	}
}

stateInCutscene = function()
{
	if cutMove
	{
		going = (point_distance(xprevious, yprevious, x, y ) > 0)
		if going {dir = point_direction(xprevious, yprevious,x, y)}
		
		image_speed = clamp(point_distance(xprevious, yprevious, x, y )/2,0,3)
		
		facing = dir div 90;
		
		animate();	
	}
	
	rot = image_angle;
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

backToSolidGround = function()
{
    SFX sn3sRespawn
	blinkExt(alpha,"alpha",1,30)
	x = global.solidGroundX;
	y = global.solidGroundY;	
}

state = stateFree;