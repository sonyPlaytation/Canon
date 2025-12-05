
event_inherited()

canPickup = true;

itemStruct = global.items[$ item ]

myScript = function()
{
	var myItem = global.items[$ item ]
	if addItem(myItem){ saveRoomObjectFlag(flagID,true) instance_destroy() }
	else canPickup = false;
	alarm[0] = 5
}