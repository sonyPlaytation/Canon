/// @

event_inherited();

if place_meeting(x,y,oRoomExit)
{
	myExit = instance_place(x,y,oRoomExit)
	myExit.locked = true;
} else instance_destroy();
