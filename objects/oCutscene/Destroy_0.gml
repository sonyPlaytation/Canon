
instance_destroy(oCutCam);

layer_sequence_destroy(thisScene)
trigger.cutscenePlaying = noone;

with oPlayer
{
	hasControl = true;
	state = stateFree;
}

for (var i = 0; i < 2; i++)
{
	with pFollower
	{
		state = stateFollow
		caughtUp = false
		inPosition = false
	}
}

oInputReader.alphaTarg = 1;
