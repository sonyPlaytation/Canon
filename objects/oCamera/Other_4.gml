/// @


global.cam.follow = follow;

if asset_has_tags(room,"darkRoom",asset_room) and !instance_exists(oDarkness)
{
	instance_create_depth(0,0,0,oDarkness);
}