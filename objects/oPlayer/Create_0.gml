/// @

playerSetup();



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