/// @

global.screenHalfX = global.cam.get_x()+(GAME_W/2)
global.screenHalfY = global.cam.get_y()+(GAME_H/2)

if layer_sequence_exists("transition",global.currentTransition)
{
	layer_sequence_x(global.currentTransition,global.screenHalfX)	
	layer_sequence_y(global.currentTransition,global.screenHalfY)	
}

layer_set_visible("CollTiles",global.debug)