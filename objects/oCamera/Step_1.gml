/// @

if sequence_exists(global.currentTransition)
{
	layer_sequence_x(global.currentTransition,global.cam.x)
	layer_sequence_y(global.currentTransition,global.cam.y)
}

layer_set_visible("CollTiles",global.debug)