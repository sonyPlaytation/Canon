
sprite_index = bg;
layerCount = image_number

funcPerLayer = array_create(layerCount,-1)

xArr = []
yArr = []

for (var i = 0; i < layerCount; i++)
{
	var _layer = $"bg_{i}"
	layer_create(layer_get_depth("Background")-(i+1*10),_layer)
	
	var _layerbg = layer_background_create(_layer,bg);
	layer_background_index(_layerbg,i);
	layer_background_speed(_layerbg,0);
	layer_background_htiled(_layerbg,true);
	
    xArr[i] = 0;
    yArr[i] = 0;
	
}

scroll = 0;