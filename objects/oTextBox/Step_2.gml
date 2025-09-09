
switch (yMode)
{
	//case TXTPOS.TOP: 
	//	y = 0; 
	//	portraitY = display_get_gui_height()
	//break;
	
	default:
	case TXTPOS.MID:
	
		width = string_width_scribble(text) + (margin)
		height = 30;
		y = display_get_gui_height()/2 - 12; 
		x = display_get_gui_width()/2 - (width/2)
		
	break;
	
	
	case TXTPOS.BTM: 
		y = display_get_gui_height() - height - padding; 
	break;
}

drawNow = true;