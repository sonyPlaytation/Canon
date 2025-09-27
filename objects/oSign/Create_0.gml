// Inherit the parent event
event_inherited();

myScript = function(myTopic)
{
	var text = ""
	
	switch(oPlayer.facing)
	{
		case 1: text = shortMsg break;
	
		default: text = "You can't read it at this angle." break;	
	}
	
	shortMessage(text)
	
}