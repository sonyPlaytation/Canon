

entities = []

returnRoom = room;
if instance_exists(pEnemy) and global.enemiesKilled[$ room] == undefined 
{ global.enemiesKilled[$ room] = [] }

for(var i = 0; i < instance_number(pEnemy); i++)
{
	var guy = instance_find(pEnemy,i);
	array_push( entities, { id : guy.id, x : guy.x, y : guy.y });
}
