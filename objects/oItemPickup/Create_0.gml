
event_inherited()

canPickup = true;

myScript = function()
{
	if addItem(item){ saveRoomObjectFlag(flagID,"collected",1) instance_destroy() }
	else canPickup = false;
	alarm[0] = 5
}