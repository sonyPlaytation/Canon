if instance_exists(oTextBox) exit;
	
color = c_white;

if position_meeting(global.mX,global.mY,id)
{
	color = c_yellow
	if mouse_check_button(mb_left)
	{
		options[$ doThis].func()
	}
}

if string_lower(doThis) = "loadsavefile" and !file_exists(SAVEFILE) {instance_destroy()}