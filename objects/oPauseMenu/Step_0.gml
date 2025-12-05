/// @

controls();

x = lerp(x,xTarg,lerpSpd);

if active 
{
	//if InputPressed(INPUT_VERB.DOWN) or InputPressed(INPUT_VERB.UP){SFX sNarr}
	
    var item = options[$ currentMenu]
    
	hover += vert;
	if hover > array_length(item)-1 {hover = 0;}
	if (hover < 0 ) { hover = array_length(item)-1; }
	
	if (accept or item[hover].type == "slider") and item != undefined
	{
		if item[hover].allowed
		{
			if item[hover].func != undefined
			{
				//show_debug_message("Selected Option: "+item[hover].label)
				item[hover].func();
				InputVerbConsume(INPUT_VERB.ACCEPT);
			}
		}
	}
}

if canDestroy and back
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

if canDestroy and (close) {destroyMenu = true;}

if !destroyMenu 
{ 
	xTarg = 36; 
}
else 
{
	if x >= 22 {alarm[0] = 5;}
	xTarg = -175;
    alphaTarg = 0
}