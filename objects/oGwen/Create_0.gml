/// @


// Inherit the parent event
event_inherited();

stateIdle = function()
{
	if facing > 3 {facing = 0}
	animate()
}

anims = 
{
	idle : sGwenIdle,
	walk : {
		U : sGwenWalkU,	
		D : sGwenWalkD,	
		L : sGwenWalkL,	
		R : sGwenWalkR,	
	}
}

dir = 0;

image_index = facing;

state = stateIdle;
