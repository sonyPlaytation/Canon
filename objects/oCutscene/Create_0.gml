frame = 0;
sceneTitle = sequence_get(scene).name;

myLayer = layer_create(-500);

thisScene = layer_sequence_create(myLayer, x, y,scene);
sceneStruct = layer_sequence_get_instance(thisScene);

actors = sequence_get_objects(scene)
for (var i = 0; i < array_length(actors); i++)
{
	if instance_exists(actors[i])
	{
		actorReplace = instance_find(actors[i],0)
		sequence_instance_override_object(sceneStruct,actors[i],actorReplace)
	}
}

layer_sequence_play(thisScene);