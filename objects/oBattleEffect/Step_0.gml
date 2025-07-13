/// @

if timer <= 0
{
	var scale = random_range(0.85,1.25)
	image_xscale = scale;
	image_yscale = scale;
	
	image_angle = irandom(360)
	
	timer = timeReset
}

timer--;