/// @

event_inherited()

depth = -bbox_bottom;
if !collide { mask_index = sBlank; }

tiles = layer_tilemap_get_id("CollTiles");

if collide
{ colls = [oColl,pEntity,pProtag,tiles]; } else {colls = [oColl,tiles]}

myScript = function(myTopic)
{
	startDialogue(myTopic)
}

selfCenter = y;

advantage = 0;
startingBattle = false;
killed = -1;

// wandering
if doWander
{
	homeX = xstart;
	homeY = ystart;
	homeSize = 96;
	wanderTime = 60;
	spd = 0;
	facing = irandom(8);
	dir = facing * 45;

	dx = lengthdir_x(spd,dir);
	dy = lengthdir_y(spd,dir);
}

// chasing
if doChase
{
	tooFar = homeSize * 2.5;
	inChase = false;
	alertJump = false
	zsp = 0;
	grv = 0.3
}

z = 0;

enemyStuff = function()
{
	if instance_exists(oTextBox) {exit};
	
	if isEnemy
	{
		var myEncounter = encounter[irandom(array_length(encounter)-1)]
	
		if !killed and !array_contains(myEncounter, undefined) and collision_circle(x,y,sprite_width*0.65,oPlayer, false, false) 
		and !startingBattle and oPlayer.iFrames <= 0
		{
			global.pauseEvery = true;
			oPlayer.hasControl = false;
			startingBattle = true;
	
			var advRoll = irandom(2)-1
		
			advantage = advRoll
		
			if instance_exists(oDarkness)//or  (collision_line(x,selfCenter,lengthdir_x(24,dir),lengthdir_y(24,dir),oPlayer,false,false) and facing == oPlayer.facing)
			{ advantage = -1; }
			
			if oPlayer.state = oPlayer.stateDash
			{ advantage++ }
	
			if forceAdvantage != noone {advantage = forceAdvantage}
	
			if advantage == -1 {set_song_ingame(mPHFightStartDisadv,,,true)} else set_song_ingame(mPHFightStartAdv,,,true)
			global.advantage = advantage;
			global.fightStarter = id;
			global.fightEnemies = myEncounter;
			global.fightBG = bg;
			global.fightSong = bgm;
			instance_create_depth(0,0,0,oRoomCapture);
			
			alarm[0] = 60;
		}
	}

	if doWander and !inChase
	{
		wanderTime--;	
		if wanderTime <= 0 
		{
			wanderTime = irandom_range(25,95);
			spd = choose(walkSpd,0);
			facing = irandom(8);
			dir = (facing * 45) mod 360;
		}
	
		if point_distance(x,y,homeX,homeY) > homeSize
		{ dir = (point_direction(x,y,homeX,homeY)); wanderTime = 30 }
	
		dx = lengthdir_x(spd,dir);
		dy = lengthdir_y(spd,dir);
	
		move_and_collide(dx,dy,colls);
	}

	if doChase
	{
		zsp -= grv;
		z += zsp;
	
		if z + zsp <= 0 
		{
			zsp = 0;
			z = 0;
		}
	
		var chaseColls = [oColl,tiles]
	
		if !collision_line(x,y,oPlayer.x,oPlayer.y,chaseColls,false,true) 
		and distance_to_point(oPlayer.x,oPlayer.y) < chaseRange and distance_to_point(homeX,homeY) < tooFar
		{
			if !alertJump
			{
				if scuttleHome
				{
					homeX = x;
					homeY = y;
				}
				dir = point_direction(x,y,oPlayer.x,oPlayer.y);
				zsp = 2;
				alertJump = true;
			}
		
			spd = walkSpd * 1.15
			inChase = true
			var playerDir = point_direction(x,y,oPlayer.x,oPlayer.y);

			dir += sin(degtorad(playerDir-dir))*2
		
			if z <= 0
			{
				dx = lengthdir_x(spd,dir);
				dy = lengthdir_y(spd,dir);
	
				move_and_collide(dx,dy,colls);
			}
		}
		else 
		{
			inChase = false;
			alertJump = false;
		}
	}
}