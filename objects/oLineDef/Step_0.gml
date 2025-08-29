

if place_meeting(x,y,oPlayer) and !active
{
	active = true
	myScript()
}

if !place_meeting(x,y,oPlayer) and active 
{ active = false }