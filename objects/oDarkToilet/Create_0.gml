// Inherit the parent event
event_inherited();

myScript = function()
{
	startDialogue(myTopic)
	
	AFTERTEXT
	{
		if dialogueResponse
		{
			oPlayer.hasControl = false
			if oBathroomStall.image_index == 1 {SFX snDoorClose}
			oBathroomStall.image_index = 0;	
			audio_pause_sound(global.songPlaying)
			oDarkToilet.alarm[0] = 60;
			oBathroomStall.mask_index = -1
		}
		else if FLAGS[$ "officeBathroomKey"] == false { startDialogue("checkBathroomKey") }
	}
}