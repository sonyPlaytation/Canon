/// @

x = lerp(x,xTarg,lerpSpd);

if active
{
	//if InputPressed(INPUT_VERB.DOWN) or InputPressed(INPUT_VERB.UP){SFX sNarr}
	
	owner.active = false
	hover += InputPressed(INPUT_VERB.DOWN) - InputPressed(INPUT_VERB.UP);
	if hover > array_length(options)-1 {hover = 0;}
	if (hover < 0 ) { hover = array_length(options)-1; }
	
	if InputPressed(INPUT_VERB.ACCEPT)
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
	
	if InputPressed(INPUT_VERB.CANCEL)
	{
		if subMenuLevel == 0 destroyMenu = true;
	}
}

if !destroyMenu
{
	xTarg = xstart + 24;
	alphaTarg = 1;
}
else 
{
	xTarg = xstart-24;
	alphaTarg = 0;
	if alpha <= 0.05 instance_destroy();
	owner.active = true;
}