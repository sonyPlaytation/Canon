/// @

if place_meeting(x,y,oPlayer) and !locked
{
	oPlayer.hasControl = false;
	
	if facing == -1 {facing = oPlayer.facing}
	
	transition(target,outType,inType,,moveX,moveY,facing);	
	
	if endTempSong { end_temp_song() }
}