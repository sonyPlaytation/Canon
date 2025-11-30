

if place_meeting(x,y,oPlayer) and (rapidFire or !active)
{
	active = true
	myScript()
}

if !place_meeting(x,y,oPlayer) and active 
{ active = false }