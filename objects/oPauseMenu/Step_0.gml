/// @

x = lerp(x,xTarg,lerpSpd);

if active 
{
	//if InputPressed(INPUT_VERB.DOWN) or InputPressed(INPUT_VERB.UP){SFX sNarr}
	
	hover += InputPressed(INPUT_VERB.DOWN) - InputPressed(INPUT_VERB.UP);
	if hover > array_length(options[$ currentMenu])-1 {hover = 0;}
	if (hover < 0 ) { hover = array_length(options[$ currentMenu])-1; }
	
	if InputPressed(INPUT_VERB.ACCEPT) and options[$ currentMenu] != undefined
	{
		if options[$ currentMenu][hover].allowed
		{
			if options[$ currentMenu][hover].func != undefined
			{
				show_debug_message("Selected Option: "+options[$ currentMenu][hover].label)
				options[$ currentMenu][hover].func();
				InputVerbConsume(INPUT_VERB.ACCEPT);
			}
		}
	}
}

if canDestroy and InputPressed(INPUT_VERB.CANCEL)
{
	//show_debug_message("Return to MenuLayer: "+options[$ currentMenu][hover].label)
	if currentMenu == "Menu" 
	{
		destroyMenu = true;
	}
	else
	{
		var _struct = array_pop(prevMenus)
		currentMenu = _struct.menu;
		hover = _struct.hover;	
	}
}

if canDestroy and (InputPressed(INPUT_VERB.PAUSE) or InputPressed(INPUT_VERB.SKIP)) {destroyMenu = true;}

if !destroyMenu 
{ 
	xTarg = 36; 
}
else 
{
	if x >= 22 {alarm[0] = 5;}
	xTarg = -175;

}