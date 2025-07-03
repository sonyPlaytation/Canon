/// @

if place_meeting(x,y,oPlayer)
{
	oPlayer.hasControl = false;
	transition(target,outType,inType,,moveX,moveY,facing);	
}