menuControls()

x = lerp(x,xTarg,lerpSpd);

if active 
{
	//if InputPressed(INPUT_VERB.DOWN) or InputPressed(INPUT_VERB.UP){SFX sNarr}	
    hover += vert;
	if hover > array_length(options)-1 {hover = 0;}
	if (hover < 0 ) { hover = array_length(options)-1; }
    
	if accept
	{
		if (array_length(options[hover]) > 1) and (options[hover][3] == true)
		{
			if options[hover][1] != -1
			{
				var _func = options[hover][1];
				if options[hover][2] != -1 {script_execute_ext(_func,options[hover][2]);} 
				else
				{
					_func();
				}
			}
		}
	}
}

if !destroyMenu { 
	xTarg = global.cam.get_x() + 36; 
} else {
	if x >= global.cam.get_x() + 22 {alarm[0] = 5;}
	xTarg = global.cam.get_x()-175;
}