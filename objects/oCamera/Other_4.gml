/// @

//TODO: change the overlay objects spawn methods to use structs to loop through that have each tag
alarm[1]=1
if asset_has_tags(room,"darkRoom",asset_room) and !instance_exists(oDarkness) {
	instance_create_depth(0,0,0,oDarkness);
}

if asset_has_tags(room,"sandstorm",asset_room) and !instance_exists(oSandstorm) {
	instance_create_depth(0,0,0,oSandstorm);
}

if layer_sequence_exists("transition",global.currentTransition)
{
	layer_sequence_x(global.currentTransition,global.screenHalfX)	
	layer_sequence_y(global.currentTransition,global.screenHalfY)	
}