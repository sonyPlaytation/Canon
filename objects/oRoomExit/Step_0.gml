/// @

if place_meeting(x,y,oPlayer) and !locked
{
	
	if facing == -1 {facing = oPlayer.facing}
		
	with oPlayer
	{
		hasControl = false;
		facing = other.facing;
		state = stateTransition();
	}
	
	transition(target,outType,inType,,moveX,moveY,facing,defaultSpawn);	

}