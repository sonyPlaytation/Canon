/// @

oInputReader.alphaTarg = 1;
InputVerbConsume(INPUT_VERB.ACTION);

if instance_exists(oCutscene)
{
	with oCutscene {(layer_sequence_play(thisScene))}
} else if instance_exists(oPlayer) oPlayer.hasControl = true;

//InputVerbConsume(INPUT_VERB.SKIP)

postDialogue();