/// @

if place_meeting(x,y,oPlayer)
{
	oPlayer.hasControl = false;
	
	if facing == -1 {facing = oPlayer.facing}
	
	transition(target,outType,inType,,moveX,moveY,facing);	
}