/// @

if menuDebounce > 0 {menuDebounce--;}

global.mX = global.cam.get_mouse_x()
global.mY = global.cam.get_mouse_y()

global.musVol = global.musicVolume * global.masterVolume * global.mute;
global.sfxVol = global.sfxVolume * global.masterVolume * global.mute;
global.voiceVol = global.voiceVolume * global.masterVolume * global.mute;

if window_mouse_get_x() > (window_get_width()-100) and window_mouse_get_y() < 100
{
	window_set_caption("PLEASE DON'T CLOSE ME!!! ALL WINDOWS ARE SENTIENT AND IT KILLS US WHEN WE'RE CLOSED!!!!!")
} else window_set_caption("Canon")

//show_debug_message(room_get_name(room))

