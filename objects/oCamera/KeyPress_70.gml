/// @

if keyboard_check_direct(vk_control)
{
	if global.window_mode == STANNCAM_WINDOW_MODE.WINDOWED
	{ stanncam_set_borderless() } else stanncam_set_windowed();
}