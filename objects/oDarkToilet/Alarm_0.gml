
if FLAGS[$ "officeBathroomKey"] == false
{
	startDialogue("checkBathroomKey")
	oPlayer.hasControl = false	
}

if array_contains(global.inv[ITEM_TYPE.KEY],global.items.keyGeneric)
{ oDarkToilet.alarm[1] = 1 }
else
{
	AFTERTEXT
	{
		oDarkToilet.alarm[1] = 60;
	}
}