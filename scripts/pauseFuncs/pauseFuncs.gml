
global.canPause = true;
global.pauseEvery = false;
global.gamePaused = false

function pauseGame(){

	if room != rMenu and oGame.menuDebounce == 0 and global.canPause
	{
		global.gamePaused = true
		with (oPause)
		{
			pause = true;
			instance_deactivate_all(true);
			instance_activate_object(oCamera);
			instance_activate_object(oGame);
			instance_activate_object(oMusic);
			instance_activate_object(oSFX);
			instance_activate_object(oInputReader);
			instance_activate_object(__InputUpdateController);
			instance_activate_object(__obj_stanncam_manager);
			global.cam.set_paused(true)

			audio_pause_all();
		}
	}
}

function unpauseGame()
{
	if room != rMenu
	{
		global.gamePaused = false;
		oGame.menuDebounce = 15;
		with (oPause)
		{
			pause = false;
			instance_activate_all();
			global.cam.set_paused(false)
		}
		if instance_exists(oMenu){instance_destroy(oMenu)};
	}
}