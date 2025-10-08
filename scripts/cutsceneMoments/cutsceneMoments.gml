
// initialize a list of cutscenes to put moments into
global.cutsceneMoments = {}

// get a list of all the sequences tagged as cutscenes
// create an empty array under each cutscenes name
var scenes = tag_get_assets("cutscene");
for (var i = 0; i < array_length(scenes); i++)
{
	var scene = asset_get_index(scenes[i])
	var length = sequence_get(scene).length
	global.cutsceneMoments[$ scenes[i]] = array_create(length)
}

function sceneAddMoment(scene, frame = 0, callback = noone )
{

	if frame < 0 {frame = sequence_get(scene).length+frame}
	
	if scene != "" and callback != noone
	{
		var name = sequence_get(scene).name;
		global.cutsceneMoments[$ name][frame] = callback
	}
}


#region MOMENTS

sceneAddMoment(cutAct1TowerFall, 1, function()
{
	oPlayer.sprite_index = sNilsIdle
	oPlayer.drawShadow = false
});

sceneAddMoment(cutAct1TowerFall, -30, function()
{
	transition(rTest1,sqFadeOut,sqFadeIn,,,,0,true)
});

sceneAddMoment(cutCharlieFindsYou, -45, function()
{
	transition(rTest2,sqFadeOut,sqFadeIn,,,,0,true)
});

#endregion