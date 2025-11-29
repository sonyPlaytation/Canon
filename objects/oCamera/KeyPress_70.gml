/// @

if keyboard_check_direct(vk_control)
{
	if global.window_mode == STANNCAM_WINDOW_MODE.WINDOWED { 
        
        stanncam_set_borderless();
        window_set_cursor(cr_none);
    } 
    else { 
        
        stanncam_set_windowed(); 
        window_set_cursor(cr_default); 
        window_center(); 
    }
}