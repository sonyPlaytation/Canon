
for (var i = 0; i < array_length(entities); i++)
{
	
	var guy = entities[i].id
		
	if guy != noone
	{
		guy.x = entities[i].x;
		guy.y = entities[i].y;
	}
	
	if guy == global.fightStarter
	{
		guy.killed = 90;
		global.fightStarter = noone;
		array_push(global.enemiesKilled[$ room ],guy.id);
	}
	
	oPlayer.iFrames = 90;
}

instance_destroy();