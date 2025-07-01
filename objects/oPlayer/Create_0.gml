/// @

playerSetup();

colls = [oColl,pEntity,tiles];

// follower stuff
followLength = 48
for (var i = followLength-1; i >= 0 ; i--)
{
	posX[i] = x;
	posY[i] = y;
}

cFollow = true;
cDist = 16
Charlie = noone

mFollow = true;
mDist = cDist + 18
Matthew = noone;

diagFix = false;

groundMove = function()
{
	var spdNow;
	if InputCheck(INPUT_VERB.RUN){spdNow = runsp} else {spdNow = walksp}
	
	var xinput = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
	var yinput = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
	var going = (point_distance(0, 0, xinput, yinput) > 0);
	
	if going 
	{
		dir = point_direction(0, 0, xinput, yinput);
		spd = spdNow;
	}
	else
	{ spd = 0; }
	
	if diagFix
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