/// @

bgx += 0.5;
global.cam.set_paused(global.midTransition);



if instance_exists(oCutCam)
{
	follow = oCutCam
	global.cam.follow = follow;
}
else 
{
	if instance_exists(oPlayer)
	{
		follow = oPlayer;
		global.cam.follow = follow;
	}
}