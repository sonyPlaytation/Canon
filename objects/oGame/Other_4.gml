/// @

var tiles = layer_get_id("CollTiles");
var coll = layer_get_id("Coll");

layer_set_visible(tiles, false);
layer_set_visible(coll, false);

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
	
	var player = instance_create_layer(_x,_y,"Player",oPlayer);
	player.facing = global.moveFacing;	
	player.hasControl = false;
	global.cam.move(_x,_y,1);
	
	alarm[0] = 2;
	
	global.defaultRoomPosition = false
}

