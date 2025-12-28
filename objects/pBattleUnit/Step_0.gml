/// @

selfCenter = y - (sprite_height/2)

if stats.hp == 0 { 
	
    if !alreadyDead
	{
		if sprite_index != sprites.down
		{
			ds_list_shuffle(dieText);
			myDied = ds_list_find_value(dieText,0);
			with oBattle {
				BATTLE(other.myDied,other.name);
			}
		}
		alreadyDead = true
		sprite_index = sprites.down 
        statuses = []
	}
} else {
	if sprite_index == sprites.down {sprite_index = sprites.idle; alreadyDead = false}
}

if forward
{
    if sprites[$ "slide"] != undefined and percent < percentTarg {sprite_index = sprites.slide}
    
	percent += 1/60
	var position = animcurve_channel_evaluate(curve,percent);
			
	var _start = xstart
	var _end = xstart + (TILE_SIZE*2*image_xscale);
	var _dist = _end - _start; 
	
	if percent >= 0.75 {percent = 1};
			
	x = _start + (_dist * position);
} 
else
{
	percent = 0
	x = lerp(x, xstart, 0.25);	
}