/// @


// Inherit the parent event
event_inherited();

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

state = stateInCutscene;
