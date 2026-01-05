if array_contains(FLAGS.cutscenes,scene) instance_destroy()

if cutscenePlaying == noone and scene != -1 and place_meeting(x,y,oPlayer) and !instance_exists(oCutscene)
{ 
	if array_contains(FLAGS.cutscenes,scene) {instance_destroy() exit;}
		
	with oPlayer {
		
		state = stateStartCutscene;
		gotoX = other.playX
		gotoY = other.playY
	}
	
	if instance_exists(oCharlie) {
		
		with oCharlie {
			
			state = stateStartCutscene;
			if follow and instance_exists(oCutStartC) {
				
				myCutStart = oCutStartC
				gotoX = myCutStart.x
				gotoY = myCutStart.y
			}
		}
	}
	
	if instance_exists(oMatthew) {
		
		with oMatthew {
			
			state = stateStartCutscene;
			if follow and instance_exists(oCutStartM) {
				
				myCutStart = oCutStartM
				gotoX = myCutStart.x
				gotoY = myCutStart.y
			}
		}
	}
	
	if myAnchor != noone{
		playX = myAnchor.x;
		playY = myAnchor.y;
	}
	
	if oPlayer.inPosition 
	and ( !instance_exists(oMatthew) or (instance_exists(oMatthew) and oMatthew.inPosition) )
	and ( !instance_exists(oCharlie) or (instance_exists(oCharlie) and oCharlie.inPosition) )
	{
		var sceneName = string(sequence_get(scene).name)
		show_debug_message($"starting cutscene {sceneName}")
		cutscenePlaying = scene; 
		oPlayer.state = oPlayer.stateInCutscene
		
		startCutscene(scene,playX,playY);
		
		if selfDestruct 
		{
			array_push(FLAGS.cutscenes,scene)
			instance_destroy();
		}
	}
}