/// @

if !place_meeting(x,y,colls) and !place_meeting(x,y,oDashGap)
{
	global.solidGroundX = x;
	global.solidGroundY = y;
}

updateFollowers();

// Inherit the parent event
event_inherited();