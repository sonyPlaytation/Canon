/// @

selfCenter = y - (sprite_height/2)

if hp <= 0 
{ 
	if sprite_index != sprites.down
	{
		ds_list_shuffle(dieText);
		myDied = ds_list_find_value(dieText,0);
		with oBattle
		{
			BATTLE(other.myDied,other.name);
		}
	}
	
	sprite_index = sprites.down 
}
else
{
	if sprite_index == sprites.down {sprite_index = sprites.idle}
}