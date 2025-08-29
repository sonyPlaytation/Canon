/// @

if menuDebounce > 0 {menuDebounce--;}

global.mX = global.cam.get_mouse_x()
global.mY = global.cam.get_mouse_y()

if window_mouse_get_x() > (window_get_width()-100) and window_mouse_get_y() < 100
{
	window_set_caption("PLEASE DON'T CLOSE ME")
} else window_set_caption("Canon")