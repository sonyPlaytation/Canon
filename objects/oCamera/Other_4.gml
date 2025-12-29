/// @

alarm[1] = 1

for (var i = 0; i < array_length(overlays); i++)
{
    var _ovr = overlays[i]
    if asset_has_tags(room,_ovr.tag, asset_room) {instance_create_depth(0,0,0, _ovr.obj)};
    if _ovr[$ "func"] != undefined {_ovr.func()};
}

//if layer_sequence_exists("transition",global.currentTransition)
//{
	//layer_sequence_x(global.currentTransition,global.screenHalfX)	
	//layer_sequence_y(global.currentTransition,global.screenHalfY)	
//}