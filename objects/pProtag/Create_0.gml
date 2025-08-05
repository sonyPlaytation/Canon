// Inherit the parent event
event_inherited();

gotoX = -1;
gotoY = -1;
inPosition = false;
myCutStart = noone;

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