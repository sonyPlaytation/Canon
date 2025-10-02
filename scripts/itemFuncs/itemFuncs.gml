

global.invSize = 24;

enum ITEM_TYPE
{
	CONSUMABLE,
	ARMOR,
	MOD,
	WEAPON,
	KEY
}

enum FOOD_TAG 
{
	MEAT,
	DAIRY,
	SEAFOOD,
	SHELLFISH,
	SPICY,
	GRAIN,
	SWEETS
}

global.inv[ITEM_TYPE.CONSUMABLE] = [];
global.inv[ITEM_TYPE.ARMOR] = [];
global.inv[ITEM_TYPE.MOD] = [];
global.inv[ITEM_TYPE.WEAPON] = [];
global.inv[ITEM_TYPE.KEY] = [];

function create_item(_category, _name, _desc, _sprite, _func = undefined) constructor
{
	category = _category;
	name = _name;
	desc = _desc;
	sprite = _sprite;
	func = _func;
}

//TODO: change items to be constructors
global.items = 
{
	template:
	{
		category : ITEM_TYPE.KEY,
		sprite : sHeadNils,
		name: "TEST",
		type : "TEST",
		description: "DESCRIPTION",
		desc: "INVENTORY DESCRIPTION",
		targetRequired : true,
		targetEnemyByDefault: false,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		tags:[],
		func : function(user, targets, source = -1)
		{
			if source == -1 {
				battleChangeHP(targets[0],20,0)
			}
		}
	},
		
	burger:
	{
		category : ITEM_TYPE.CONSUMABLE,
		heal : 20,
		sprite : sItemBurger,
		name: "Cheeseburger",
		type : "item",
		description: "{1} eats a burger!",
		desc: "Heals 20 hp to one target",
		targetRequired : true,
		targetEnemyByDefault: false,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		tags : [FOOD_TAG.DAIRY,FOOD_TAG.GRAIN,FOOD_TAG.MEAT],
		func : function(user, targets)
		{ // TODO: make item funcs work universally
			if instance_exists(oBattle) {
				battleChangeHP(targets[0],heal,0)
			} 
			else 
			{
				overworldChangeHP(oPlayer,heal,0,snHealMinor)
				with oPauseMenu {destroyMenu}
			}
			
			var me = array_get_index(global.inv[category],self)
			array_delete(global.inv[category],me,1);
		}
	},
		
	keyGeneric	: new create_item(
		ITEM_TYPE.KEY,
		"Small Key", 
		"Unlocks regular doors.", 
		sItemKeyGeneric),
}

struct_foreach(global.items, function(_key, _val){
  _val[$ "key"] = _key  
  if _val[$ "category"] == ITEM_TYPE.CONSUMABLE {_val[$ "subMenu"] = "Items"}
})

function openChest(_chest)
{
	if stock > 0 and addItem(item)
	{
		if stock == fullStock {SFX snChestOpen}
		stock--;
		saveRoomObjectFlag(_chest.flagID,"stock",stock)
	}
}

function unlockDoor(_locked, _unlocked)
{
	if array_contains(global.inv[ITEM_TYPE.KEY],keyNeeded) 
	{
		locked = false;
		FLAGS[$ id] = locked
		SFX snSH2DoorUnlock
		startDialogue(_unlocked);
	} 
	else 
	{
		SFX snSH2DoorLocked
		startDialogue(_locked);
	}
}

function addItem(_item, _showMsg = true)
{
	if array_length(global.inv[_item.category]) < global.invSize
	{
		item = _item
		theItem = item.key
	
		array_push(global.inv[_item.category],_item);
	
		if _showMsg { SFX snCaveStoryGetItem; shortMessage($"Found a [c_red]{_item.name}[c_white]!",TXTPOS.MID) }
		show_debug_message($"Added Item: {_item.name} to Inventory")
		return true;
	}
	
	shortMessage($"You don't have room for this [c_red]{_item.name}[c_white].",TXTPOS.MID)
	return false;
}

function giveItemAction(_item,_count = 1) : dialogueAction() constructor
{
	item = _item;
	count = _count;
	
	act = function(textbox)
	{
		addItem(item);
		textbox.yMode = TXTPOS.MID
		shortMessage("",TXTPOS.MID)
		textbox.setText($"Found a {item.name}!")
	}
}



