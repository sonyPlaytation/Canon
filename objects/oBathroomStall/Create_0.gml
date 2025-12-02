// Inherit the parent event
event_inherited();

myScript = function(myTopic)
{
	SFX snSH2DoorUnlock;
	
	if image_index == 0 
	{
		image_index = 1

		if audio_is_paused(global.songPlaying){audio_resume_sound(global.songPlaying)}
	}else {
		if oPlayer.facing == 2 and collision_rectangle(x,y-48,x+36,y,oPlayer,false,false){
			image_index = 0
		}
	}
}