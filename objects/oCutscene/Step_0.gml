frame = layer_sequence_get_headpos(thisScene)-1;
var func = struct_get(global.cutsceneMoments, sceneTitle)
if func[frame] != undefined and func[frame]  != 0
{
	func[frame]();
}

if !global.midTransition and InputCheck(INPUT_VERB.SKIP)
{skipHeld++} else skipHeld = 0;
	
if skipHeld >= skipThreshhold 
{
	layer_sequence_headpos(thisScene,length-1);
	var sceneActions = array_filter(func,function(element, index) {
		return element!= 0
	})
	
	for (var i = 0;i < array_length(sceneActions); i++) {
		sceneActions[i]();
	}
}