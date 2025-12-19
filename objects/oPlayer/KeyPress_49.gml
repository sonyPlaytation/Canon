/// @

if global.debug cFollow = !cFollow;

if !cFollow 
{
	
	instance_destroy(Charlie);
	var pos = array_get_index(followers, Charlie)
	array_delete(followers, pos, 1)
	pos = array_get_index(PARTY, CHARLIE)
	array_delete(PARTY,pos,1)
	Charlie = noone;
}
