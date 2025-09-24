// Inherit the parent event
event_inherited();

myScript = function()
{
	startDialogue(myTopic)
	
	if !array_contains(global.inv[ITEM_TYPE.KEY], global.items.keyGeneric) and !instance_exists(oItemPickup)
	{
		var _item = instance_create_depth(264,384,depth,oItemPickup)
		_item.item = global.items.keyGeneric
	}
	
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
	}
}