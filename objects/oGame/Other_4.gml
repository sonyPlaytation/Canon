/// @

var tiles = layer_get_id("CollTiles");
var coll = layer_get_id("Coll");

layer_set_visible(tiles, false);
layer_set_visible(coll, false);

if !instance_exists(oPlayer) and global.midTransition
{
	var player = instance_create_layer(global.transitionX,global.transitionY,"Player",oPlayer);
	player.facing = global.moveFacing;	
	global.cam.x = player.x;
	global.cam.y = player.y;
}

