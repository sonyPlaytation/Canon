
global.myItems = []

function create_item(_name, _desc, _sprite, _func = -1) constructor
{
	name = _name;
	desc = _desc;
	sprite = _sprite;
	func = _func;
}

global.items = 
{
	template	: new create_item(
		"TEST", 
		"DESC", 
		sHeadNils),
		
	burger	: new create_item(
		"Double Cheeseburger", 
		"Heals 20 HP", 
		sItemBurger),
		
	keyGeneric	: new create_item(
		"Small Key", 
		"Unlocks regular doors.", 
		sItemKeyGeneric),
}

function openChest(_chest)
{
	if stock > 0 
	{
		if stock == fullStock {SFX snChestOpen}
		addItem(item);
		stock--;
	}
}

function unlockDoor(_locked, _unlocked)
{
	if array_contains(global.myItems,keyNeeded) 
	{
		myExit.locked = false;
		instance_destroy();
		startDialogue(_unlocked);
	} else startDialogue(_locked);
}

function addItem(_item)
{
	array_push(global.myItems,_item)
	
	shortMessage($"Found a {_item.name}!")
	
	show_debug_message($"Added Item: {_item.name} to Inventory")
}





