global.canPause = true;
instance_destroy(oCutCam);

layer_sequence_destroy(thisScene)
if instance_exists(trigger) {trigger.cutscenePlaying = noone;}

if instance_exists(oPlayer)
{
	with oPlayer
	{
		hasControl = true;
		state = stateFree;
	}
	oCamera.follow = oPlayer;
	instance_activate_object(obj_stanncam_zone)
}

if instance_exists(oPlayer)
{
	with pFollower
	{
		state = stateFollow
		caughtUp = false
		inPosition = false
	}
}

oInputReader.alphaTarg = 1;
