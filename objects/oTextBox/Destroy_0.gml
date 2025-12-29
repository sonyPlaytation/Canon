/// @

oInputReader.alphaTarg = 1;
InputVerbConsume(INPUT_VERB.ACTION);
InputVerbConsume(INPUT_VERB.ACCEPT);

if instance_exists(oCutscene)
{
	with oCutscene {(layer_sequence_play(thisScene))}
} else if instance_exists(oPlayer) oPlayer.hasControl = true;

//InputVerbConsume(INPUT_VERB.SKIP)
global.letterbox = global.serious;
postDialogue();