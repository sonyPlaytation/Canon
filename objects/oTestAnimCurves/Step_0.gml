

percent += 1/60
position = animcurve_channel_evaluate(curve,percent);

if percent >= 1 percent = 0;
			
var _start = xstart
var _end = xstart + (TILE_SIZE*12);
var _dist = _end - _start; 
			
x = _start + (_dist * position);