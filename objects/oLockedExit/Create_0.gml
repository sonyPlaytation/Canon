/// @

event_inherited();

locked = true;

if locked and place_meeting(x,y,oRoomExit)
{
	myExit = instance_place(x,y,oRoomExit)
	myExit.locked = locked;
} else instance_destroy();

myScript = function(myTopic)
{
	
	unlockDoor(lockedText,unlockText)
}