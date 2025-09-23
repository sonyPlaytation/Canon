/// @

var tiles = layer_get_id("CollTiles");
var coll = layer_get_id("Coll");

if layer_exists(tiles) layer_set_visible(tiles, false);
if layer_exists(coll) layer_set_visible(coll, false);

if !instance_exists(oPlayer) and global.midTransition
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
	
	var player = instance_create_layer(_x,_y,"Player",oPlayer);
	player.facing = global.moveFacing;	
	player.hasControl = false;
	global.cam.move(_x,_y,1);
	
	alarm[0] = 2;
	
	global.defaultRoomPosition = false
}

