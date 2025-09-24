/// @

event_inherited()

if forDebug and !global.debug {instance_deactivate_object(id)}

sprite_index = item.sprite;

if place_meeting(x,y,oPlayer)
{
	if canPickup {myScript()}
	alarm[0] = 5
}
