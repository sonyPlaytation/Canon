// Inherit the parent event
event_inherited();

myScript = function()
{
	if !array_contains(FLAGS.cutscenes,cutBathroomMirror) array_push(FLAGS.cutscenes,cutBathroomMirror)
	
	global.saveMessage = "// Your creepy skeletal nostril hole is bombarded with the stench of a toilet that hasn't been cleaned in at least a dozen years."
	startDialogue("save")

	if !array_contains(global.inv[ITEM_TYPE.KEY], global.items.keyGeneric) and !instance_exists(oItemPickup) {
		
		var _item = instance_create_depth(264,384,depth,oItemPickup,{item : "keyGeneric"})
	}
	
	AFTERTEXT {
		
		FLAGS.act1.narratorFunny = true;
		oPlayer.hasControl = false
		oPlayer.facing = 3
		if oBathroomStall.image_index == 1 {SFX snDoorClose}
		oBathroomStall.image_index = 0;	
		audio_pause_sound(global.songPlaying)
		oDarkToilet.alarm[0] = 60;
	}
	
	
}