/// @


InputVerbConsume(INPUT_VERB.ACTION);

if instance_exists(oCutscene)
{
	with oCutscene {(layer_sequence_play(thisScene))}
} else oPlayer.hasControl = true;