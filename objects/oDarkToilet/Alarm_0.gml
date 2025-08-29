
if FLAGS[$ "officeBathroomKey"] == false
{
	startDialogue("checkBathroomKey")
	oPlayer.hasControl = false

	AFTERTEXT
	{
		oDarkToilet.alarm[1] = 60;
	}
}
else oDarkToilet.alarm[1] = 1;