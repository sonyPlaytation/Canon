/// @


if global.debug mFollow = !mFollow;

if !mFollow 
{
	instance_destroy(Matthew);
	var pos = array_get_index(followers, Matthew)
	array_delete(followers, pos, 1)
	Matthew = noone;
}