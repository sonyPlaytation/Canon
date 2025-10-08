/// @

if iFrames > 0 { if iFrames >= 90 {blinkExt(alpha,"alpha",1,100)}; iFrames-- };

event_inherited()

var followDist = 12 * (array_length(followers)+1)
var facedir = facing * 90

if cFollow and Charlie == noone
{
	Charlie = instance_create_depth(x - lengthdir_x(20,facedir),y - lengthdir_y(20,facedir),depth,oCharlie)
	array_push(followers, Charlie);
	if !array_contains(PARTY,global.characters[1])  {
	array_push(PARTY,global.characters[1]) 
	}
}

if mFollow and Matthew == noone
{
	Matthew = instance_create_depth(x - lengthdir_x(20,facedir),y - lengthdir_y(20,facedir),depth,oMatthew)
	array_push(followers, Matthew);
	if !array_contains(PARTY,global.characters[2]) {
		array_push(PARTY,global.characters[2])
	}
}

if instance_exists(pFollower)
{
	for (var i = 0; i < array_length(followers); i++)
	{
		var guy = followers[i]
		guy.followDist = 18*(i+1);
	}
}