

event_inherited()
spd = 0
dir = 0
readyToStop = false
tilesTravelled = 0;

mycoll = noone;

myScript = function()
{
	dir = oPlayer.facing*90;
	mycoll = instance_create_depth(x,y,depth,oColl,{visible : false})
	spd = 2;
	readyToStop = false;
	tilesTravelled = 0;
	alarm[0] = 5
}