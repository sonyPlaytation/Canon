/// @

menuControls()

x = lerp(x,xTarg,lerpSpd);

if active 
{
	//if InputPressed(INPUT_VERB.DOWN) or InputPressed(INPUT_VERB.UP){SFX sNarr}
	
    var page = options[$ currentMenu]
    var item = page[hover]
    
	hover += vert;
	if hover > array_length(page)-1 {hover = 0;}
	if (hover < 0 ) { hover = array_length(page)-1; }
	
	if (accept or item.menuType == "slider") and page != undefined {
        
		if item.allowed {
            
			if item.func != undefined {
				
                item.func();
				InputVerbConsume(INPUT_VERB.ACCEPT);
			}
		}
	}
}

if back and currentMenu != "Menu" {

    var _struct = array_pop(prevMenus)
    currentMenu = _struct.menu;
    hover = _struct.hover;	
}

if !destroyMenu  { 
	
    xTarg = 36; 
} else  {
	
    if x >= 22 {alarm[0] = 5;}
	xTarg = -175;
    alphaTarg = 0
}