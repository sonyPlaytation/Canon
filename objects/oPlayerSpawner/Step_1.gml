/// @

if !instance_exists(oPlayer) and !global.midTransition
{
	instance_create_depth(x,y,depth,oPlayer)
	global.cam.follow = oPlayer
}