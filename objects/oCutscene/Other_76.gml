

if (event_data[? "event_type"] == "sequence event") // or you can check "sprite event"
{
	layer_sequence_pause(thisScene)
	startDialogue(event_data[? "message"])
}