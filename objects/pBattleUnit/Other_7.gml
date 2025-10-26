
if stats.hp == 0 
{ 
	if !alreadyDead
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
		alreadyDead = true
		sprite_index = sprites.down 
	}
}
else
{
	if sprite_index == sprites.down {alreadyDead = false}
	if acting sprite_index = sprites.idle;
}