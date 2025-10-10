if layer_sequence_is_paused(thisScene)
{
	if instance_exists(oTextBox) and oTextBox.onHold {layer_sequence_play(thisScene)}
}

if layer_sequence_is_finished(thisScene)
{
	instance_destroy();
}