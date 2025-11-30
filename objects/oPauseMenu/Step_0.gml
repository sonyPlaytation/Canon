/// @

down = InputPressed(INPUT_VERB.DOWN);
up = InputPressed(INPUT_VERB.UP);
left = InputPressed(INPUT_VERB.LEFT);
right = InputPressed(INPUT_VERB.RIGHT);
accept = InputPressed(INPUT_VERB.ACCEPT);

if InputCheck(INPUT_VERB.DOWN) {downFrames++} else downFrames = 0;
if InputCheck(INPUT_VERB.UP) {upFrames++} else upFrames = 0;
if InputCheck(INPUT_VERB.LEFT) {leftFrames++} else leftFrames = 0;
if InputCheck(INPUT_VERB.RIGHT) {rightFrames++} else rightFrames = 0;

var frameTarg = 20;
if downFrames == frameTarg {down = true; downFrames = frameTarg*0.75}
if upFrames == frameTarg {up = true; upFrames = frameTarg*0.75}
if leftFrames == frameTarg {left = true; leftFrames = frameTarg*0.75}
if rightFrames == frameTarg {right = true; rightFrames = frameTarg*0.75}

vert = down - up;
hort = right - left;

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
				show_debug_message("Selected Option: "+item[hover].label)
				item[hover].func();
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
    alphaTarg = 0
}