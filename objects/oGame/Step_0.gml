/// @

if DEV{
    var menuToggle = keyboard_check_pressed(vk_alt);
    var down = InputPressed(INPUT_VERB.DOWN);
    var up = InputPressed(INPUT_VERB.UP);
    
    if InputCheck(INPUT_VERB.DOWN) {downFrames++} else downFrames = 0;
    if InputCheck(INPUT_VERB.UP) {upFrames++} else upFrames = 0;
    
    var frameTarg = 20;
    if downFrames == frameTarg {down = true; downFrames = frameTarg*0.75}
    if upFrames == frameTarg {up = true; upFrames = frameTarg*0.75}
    
    if menuToggle {listActive = !listActive};
        
    if listActive{
        if InputPressedMany([INPUT_VERB.CANCEL, INPUT_VERB.SKIP]) {listActive = false;}
        if instance_exists(oPlayer){oPlayer.hasControl = false}
        if cursorPos < listLength-1 and down {cursorPos++} else
        if cursorPos > 0 and up {cursorPos--}
        
        if InputPressed(INPUT_VERB.ACCEPT){
            transition(roomList[cursorPos],sqFadeOut,sqFadeIn,,,,,true)
            listActive = false;
        }    
        
    } else{
        if instance_exists(oPlayer){oPlayer.hasControl = true}
    }
}

global.current_frame++

if menuDebounce > 0 {menuDebounce--;}

global.mX = global.cam.get_mouse_x()
global.mY = global.cam.get_mouse_y()

updatevolume()

if window_mouse_get_x() > (window_get_width()-100) and window_mouse_get_y() < 100
{
	window_set_caption("PLEASE DON'T CLOSE ME!!! ALL WINDOWS ARE SENTIENT AND IT KILLS US WHEN WE'RE CLOSED!!!!!")
} else window_set_caption("Canon")

//show_debug_message(room_get_name(room))

if InputPressed(INPUT_VERB.SKIP) and global.canPause and !instance_exists(oPauseMenu) and !instance_exists(oTextBox)
{
	if !instance_exists(oPauseMenu)
	{
		InputVerbConsume(INPUT_VERB.SKIP)
		instance_create_depth(global.cam.get_x(),global.cam.get_y(),-9999,oPauseMenu)	
	}
}