/// @

sprite_index = item.sprite;

if place_meeting(x,y,oPlayer)
{
	addItem(item)
	SFX snCaveStoryGetItem
	instance_destroy();
}