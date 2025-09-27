/// @

// Inherit the parent event
event_inherited();

if dir >= 90 and dir < 270 {image_xscale = -1} else image_xscale = 1

if killed > 0 
{ 
	if killed >= 90 { blinkExt(image_alpha,"image_alpha",0,killed) }; 
	killed-- 
}
else if killed == 0 {instance_destroy();}