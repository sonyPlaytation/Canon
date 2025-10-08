/// @

if !instance_exists(oPlayer) and !global.midTransition
{
	instance_create_depth(x,y,depth,oPlayer,
	{
		cFollow : cFollow,
		mFollow : mFollow
	})
	oCamera.follow = oPlayer
}