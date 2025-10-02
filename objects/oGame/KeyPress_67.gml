if global.canPause and !instance_exists(oPauseMenu) and !instance_exists(oTextBox)
{
	if !instance_exists(oPauseMenu)
	{
		InputVerbConsume(INPUT_VERB.SKIP)
		instance_create_depth(global.cam.get_x(),global.cam.get_y(),-9999,oPauseMenu)	
	}
}