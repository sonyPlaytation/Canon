if global.canPause and !instance_exists(oPauseMenu)
{
	if !instance_exists(oPauseMenu)
	{
		instance_create_depth(global.cam.get_x(),global.cam.get_y(),-9999,oPauseMenu)	
	}
}