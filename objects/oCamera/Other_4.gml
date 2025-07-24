/// @

if instance_exists(oPlayer)
{
	follow = oPlayer;
	global.cam.follow = follow;
	global.cam.x = follow.x;
	global.cam.y = follow.y;
}

if asset_has_tags(room,"darkRoom",asset_room) and !instance_exists(oDarkness)
{
	instance_create_depth(0,0,0,oDarkness);
}