/// @description Insert description here
// You can write your code in this editor


//disable alpha blending
//gpu_set_blendenable(false);

//if (pause) //screenshot of game frame while paused
//{
//	if !surface_exists(pauseSurf) {pauseSurf = surface_create(display_get_gui_width(),display_get_gui_height());}
	
//	surface_set_target(pauseSurf);
//	//buffer_set_surface(pauseSurfBuffer,pauseSurf,0);
//	surface_reset_target();
	
//	global.cam.draw_surf(pauseSurf,global.cam.get_x(),global.cam.get_y());
//}

if InputPressed(INPUT_VERB.PAUSE) and global.canPause
{
	switch (pause)
	{
		case false:
			oPlayer.JustHitEnemyButCanStillMoveALittle = 0
			pauseGame();
		break;

		case true:
			unpauseGame();
		break;
	}
}

//gpu_set_blendenable(true);