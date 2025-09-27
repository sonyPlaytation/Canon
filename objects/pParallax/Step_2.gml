

for (var i = 0; i < layerCount; i++)
{
    xArr[i] = global.cam.get_x() / (i+1);
    yArr[i] = global.cam.get_y() / (i+1);
	
	var _layer = $"bg_{i}"
	layer_x(_layer,xArr[i]); 
	
	if i == image_number-1 layer_y(_layer,yArr[i]+sprite_height)
	else 
	layer_y(_layer,yArr[i]); 
	
	if funcPerLayer[i] != -1 {funcPerLayer[i]()};
	
}
