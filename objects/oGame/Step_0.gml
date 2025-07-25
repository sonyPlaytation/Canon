/// @

if InputCheck(INPUT_VERB.PAUSE) {game_end()}
if menuDebounce > 0 {menuDebounce--;}

global.mX = global.cam.get_mouse_x()
global.mY = global.cam.get_mouse_y()
