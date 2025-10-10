

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

function sceneAddMoment(scene, frame = 0, callback = function(){} )
{

	if frame < 0 {frame = sequence_get(scene).length+frame}
	
	if scene != "" and callback != function(){}
	{
		var name = sequence_get(scene).name;
		global.cutsceneMoments[$ name][frame] = callback
	}
}

sceneAddMoment(cutAct1TowerFall, 1, function()
{
	oPlayer.sprite_index = sNilsIdle
	oPlayer.drawShadow = false
});

sceneAddMoment(cutAct1TowerFall, -30, function()
{
	transition(rCliffs_1,sqFadeOut,sqFadeIn,,,,0,true)
});


sceneAddMoment(cutCharlieFindsYou, 0, function()
{
	with oCharlie{
		fogAlpha = 1
		fogColor = c_black;
	}
});

sceneAddMoment(cutCharlieFindsYou, -45, function()
{
	transition(rCliffs_2,sqFadeOut,sqFadeIn,,,,0,true)
});


sceneAddMoment(cutBathroomMirror, 0, function()
{
	oPlayer.cutMove = true;
	instance_deactivate_object(obj_stanncam_zone) 
});
sceneAddMoment(cutBathroomMirror, 100, function()
{
	with oPlayer
	{
		cutMove = false;
		sprite_index = sNilsWalkR;
		image_speed = 0;
		image_index = 0
	}
});
sceneAddMoment(cutBathroomMirror, 150, function()
{
	with oPlayer
	{
		sprite_index = sNilsIdle;
		image_index = 1
	}
});
sceneAddMoment(cutBathroomMirror, 200, function()
{
	with oPlayer
	{
		cutMove = true;
	}
});

sceneAddMoment(cutWakeUpOffice, 0, function()
{
	instance_deactivate_object(obj_stanncam_zone) 
});

sceneAddMoment(cutWakeUpOffice, -1, function()
{
	instance_activate_object(obj_stanncam_zone) 
	oCamera.follow = oPlayer
	oPlayer.image_index = 3;
});
