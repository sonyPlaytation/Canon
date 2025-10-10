frame = 0;
sceneData = sequence_get(scene)
sceneTitle = sceneData.name;
length = sceneData.length;
skipHeld = 0;
skipThreshhold = 30;
global.canPause = false
oInputReader.alphaTarg = 0;

if instance_exists(oPlayer) {depth = oPlayer.depth}
else depth = -500

myLayer = layer_create(depth);

thisScene = layer_sequence_create(myLayer, x, y,scene);
sceneStruct = layer_sequence_get_instance(thisScene);

actors = sequence_get_objects(scene)
for (var i = 0; i < array_length(actors); i++)
{
	if instance_exists(actors[i]) and (object_is_ancestor(actors[i],pAllLivingThings) or actors[i] == oCutCam)
	{
		//show_message("Actor replaced: " + string(actors[i]))
		actorReplace = instance_find(actors[i],0)
		sequence_instance_override_object(sceneStruct,actors[i],actorReplace)
	} 
}

layer_sequence_play(thisScene);