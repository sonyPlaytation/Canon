/// @

if iFrames > 0 { if iFrames >= 90 {blinkExt(alpha,"alpha",1,100)}; iFrames-- };

event_inherited()

var followDist = 18 * (array_length(followers)+1)

if cFollow and Charlie == noone
{
	Charlie = instance_create_depth(x - lengthdir_x(followDist*2,facing),y - lengthdir_y(followDist*2,facing),depth,oCharlie)
	array_push(followers, Charlie);
}

if mFollow and Matthew == noone
{
	Matthew = instance_create_depth(x - lengthdir_x(followDist*2,facing),y - lengthdir_y(followDist*2,facing),depth,oMatthew)
	array_push(followers, Matthew);
}

if instance_exists(pFollower)
{
	for (var i = 0; i < array_length(followers); i++)
	{
		var guy = followers[i]
		guy.followDist = 18*(i+1);
	}
}