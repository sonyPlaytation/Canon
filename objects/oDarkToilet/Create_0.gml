// Inherit the parent event
event_inherited();

myScript = function()
{
	if !array_contains(FLAGS.cutscenes,cutBathroomMirror) array_push(FLAGS.cutscenes,cutBathroomMirror)
	startDialogue(myTopic)

	if !array_contains(global.inv[ITEM_TYPE.KEY], global.items.keyGeneric) and !instance_exists(oItemPickup)
	{
		FLAGS.act1.narratorFunny = false;
		initDialogue();
		var _item = instance_create_depth(264,384,depth,oItemPickup)
		_item.item = "keyGeneric"
	}
	
	AFTERTEXT
	{
		if dialogueResponse
		{
			FLAGS.act1.narratorFunny = true;
			//initDialogue();
			oPlayer.hasControl = false
			oPlayer.facing = 3
			if oBathroomStall.image_index == 1 {SFX snDoorClose}
			oBathroomStall.image_index = 0;	
			audio_pause_sound(global.songPlaying)
			oDarkToilet.alarm[0] = 60;
		}
	}
	
	
}