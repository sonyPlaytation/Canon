/// @

if !array_contains(noSpawnRooms,room) { array_insert(roomsBeenThrough, 0, room); }

var tiles = layer_get_id("CollTiles");
var coll = layer_get_id("Coll");

if layer_exists(tiles) layer_set_visible(tiles, false);
if layer_exists(coll) layer_set_visible(coll, false);

if !instance_exists(oPlayer) and !array_contains(noSpawnRooms, room)
{
	var _x, _y;
	
	if global.defaultRoomPosition
	{
		_x = oPlayerSpawner.x;
		_y = oPlayerSpawner.y;
	}
	else
	{
		_x = global.transitionX;
		_y = global.transitionY;
	}
	
	if !layer_exists("Player") layer_create(100,"Player");
	
	var player = instance_create_layer(_x,_y,"Player",oPlayer,global.characters[0]);
	player.cFollow = array_contains(PARTY,global.characters[1]);
	player.mFollow = array_contains(PARTY,global.characters[2]);
	player.facing = global.moveFacing;	
	oPlayer.hasControl = true;
	
	alarm[0] = 2;
}

if array_length(roomsBeenThrough) >= roomsTilDoom 
{array_resize(roomsBeenThrough,roomsTilDoom)}

if instance_exists(pEnemy) and array_contains(roomsBeenThrough,room)
{
	for (var j = 0; j < array_length(global.enemiesKilled[$ room]); j++)
	{
		if !global.enemiesKilled[$ room][j].killed
		instance_deactivate_object( global.enemiesKilled[$ room][j] )
	}
} else global.enemiesKilled[$ room] = []