frame = layer_sequence_get_headpos(thisScene)-1;

var func = struct_get(global.cutsceneMoments, sceneTitle)

if func[frame] != undefined and func[frame]  != 0
{
	func[frame]();
}