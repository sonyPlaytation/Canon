/// @

// Inherit the parent event
event_inherited();

if inChase
{
    time += 100
    zoffset = wave(0,10,5,0,time)
} else zoffset = approach(zoffset,0,1);