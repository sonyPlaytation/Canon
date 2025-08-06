

if cutscenePlaying == noone and scene != -1 and place_meeting(x,y,oPlayer) and !instance_exists(oCutscene)
{ 
	with oPlayer 
	{
		state = stateStartCutscene;
		gotoX = other.playX
		gotoY = other.playY
	}
	
	if instance_exists(oCharlie)
	{
		with oCharlie
		{
			state = stateStartCutscene;
			myCutStart = oCutStartC
			gotoX = myCutStart.x
			gotoY = myCutStart.y
		}
	}
	
	if instance_exists(oMatthew)
	{
		with oMatthew
		{
			state = stateStartCutscene;
			myCutStart = oCutStartM
			gotoX = myCutStart.x
			gotoY = myCutStart.y
		}
	}
	
	if oPlayer.inPosition 
	and ( !instance_exists(oMatthew) or (instance_exists(oMatthew) and oMatthew.inPosition) )
	and ( !instance_exists(oCharlie) or (instance_exists(oCharlie) and oCharlie.inPosition) )
	{
		show_debug_message($"starting cutscene {string(scene)}")
		cutscenePlaying = scene; 
		oPlayer.state = oPlayer.stateInCutscene
		
		startCutscene(scene,playX,playY);
		
		if selfDestruct instance_destroy();
	}
}