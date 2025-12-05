

global.invSize = 24;

function Item(_name, _type, _desc = "") constructor {
	
	// Universal 
	category = _type;
	name = _name;
	desc = _desc;
	
	//ARMOR
	usedBy = [];
	sprite = sBlank;
	stats =  {
		
		lvl : 0, // level requirement
		EXP : 0, // passive exp bonus 
		hp: 0, // passive extra hp gained
		hpMax: 0, // passive extra max health
		// ex equivalents are in int stat (see below)
	
		// Stats below are self explanatory
		str: 0,
		def: 0,
		exStr: 0,
		exDef: 0,
		int: 0, // intelligence governs the amount of EX you have, and how fast your meter builds
		spd: 0, // speed is turn order and also move timer bonus time
		cha: 0,
		luk: 0
	};
	
	atkTypes = [];
	defTypes = [];
	tags = [];
	
	info = {
		desc : "",
		types : [],
		input : "",
		exCost : 0
	};
	
	// Attacks
	notation = ""; //global.moves 
	submenu = -2;
	exCost = 0;
	frameCost = 0;
	
	targetRequired = true;
	targetEnemyByDefault = true;
	targetAll = MODE.NEVER;
	
	userAnimation = "idle";
	fxSprite = sPunch;
	effectOnTarget = MODE.ALWAYS;
	hitSound = snHit8;
	
	func = function(){};
	draw = function(){};
	value = 0;
	args = [];
	
	static setName = function(v){ name = v; return self; };
	static setDesc = function(v){ desc = v; return self; };
	static setUsedBy = function(v){ usedBy = v; return self; };
	static setSprite = function(v){ sprite = v; return self; };
		
	static setStats = function(
		lvl = 0,
		EXP = 0,
		hp = 0,
		hpMax = 0,
		str = 0,
		def = 0,
		exStr = 0,
		exDef = 0,
		int = 0,
		spd = 0,
		cha = 0,
		luk = 0
	){
		stats.lvl = lvl;
		stats.EXP = EXP;
		stats.hp = hp;
		stats.hpMax = hpMax;
	
		stats.str = str;
		stats.def = def;
		stats.exStr = exStr;
		stats.exDef = exDef;
	
		stats.int = int;
		stats.spd = spd;
		stats.cha = cha;
		stats.luk = luk;
		return self;
	};
	
	static setLvl = function(v){ stats.lvl = v; return self; };
	static setEXP = function(v){ stats.EXP = v; return self; };
	static setHp = function(v){ stats.hp = v; return self; };
	static setHpMax = function(v){ stats.hpMax = v; return self; };
	static setStr = function(v){ stats.str = v; return self; };
	static setDef = function(v){ stats.def = v; return self; };
	static setExStr = function(v){ stats.exStr = v; return self; };
	static setExDef = function(v){ stats.exDef = v; return self; };
	static setInt = function(v){ stats.int = v; return self; };
	static setSpd = function(v){ stats.spd = v; return self; };
	static setCha = function(v){ stats.cha = v; return self; };
	static setLuk = function(v){ stats.luk = v; return self; };

	static setAtkTypes = function(v){ atkTypes = v; return self; };
	static setDefTypes = function(v){ defTypes = v; return self; };
	static setTags = function(v){ tags = v; info.tags = v; return self; };
	
	static setInfoDesc = function(v){ info.desc = v; return self; };
	static setInfoTypes = function(v){ info.types = v; return self; };
	static setInfoInput = function(v){ info.input = v; return self; };
	
	static setNotation = function(v){ notation = v; return self; };
	static setSubmenu = function(v){ submenu = v; return self; };
	static setExCost = function(v){ exCost = v; info.exCost = v; return self; };
	static setFrameCost = function(v){ frameCost = v; return self; };
	
	static setTargetRequired = function(v){ targetRequired = v; return self; };
	static setTargetEnemyByDefault = function(v){ targetEnemyByDefault = v; return self; };
	static setTargetAll = function(v){ targetAll = v; return self; };
	
	static setUserAnimation = function(v){ userAnimation = v; return self; };
	static setFxSprite = function(v){ fxSprite = v; return self; };
	static setEffectOnTarget = function(v){ effectOnTarget = v; return self; };
	static setHitSound = function(v){ hitSound = v; return self; };
	
	static setFunc = function(v){ func = v; return self; };
	static setDraw = function(v){ draw = v; return self; };
	static setValue = function(v){ value = v; return self; };
	static setArgs = function(v){ args = v; return self; };

}

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

#region item function archetypes

	function consume(user, targets = [global.characters[CHAR.NILS]], _val) { 
		
		item = global.items[$ self.key];
		if is_undefined(_val) _val = item.value;
		category = item.category;
		
		if instance_exists(oBattle) {
			battleChangeHP(targets[0],_val,0)
		} 
		else 
		{
			// TODO: need to figure out how to discern or otherwise select user and target from within menu
			overworldChangeHP(oPlayer,_val,0)
			show_debug_message(self);
			show_debug_message(targets);
			show_debug_message(_val);
			
			var me = array_get_index(other.options[$ "Consumables"],self);
			array_delete(other.options[$ "Consumables"],me,1);
			
			if other.hover == array_length(other.options[$ "Consumables"])-1 {other.hover--}
		}
		
		var me = array_get_index(global.inv[category],item);
		array_delete(global.inv[category],me,1);
	}

#endregion

function initItems(){
	
	global.inv[ITEM_TYPE.CONSUMABLE] = [];
	global.inv[ITEM_TYPE.ARMOR] = [];
	global.inv[ITEM_TYPE.MOD] = [];
	global.inv[ITEM_TYPE.WEAPON] = [];
	global.inv[ITEM_TYPE.KEY] = [];
	
	//TODO: change items to be constructors
	global.items = 
	{
		armorTest: new Item("Basic Armor", ITEM_TYPE.ARMOR)
			.setUsedBy(CHAR.NILS)
			.setSprite(sHeadNils)
			.setDesc("SHITTY ASS ARMOR")
			.setStats(1,,,,,4,,1)
			.setDefTypes([MOVE_TYPE.PHYS])
			.setFunc(equipArmor)
			.setDraw(drawItem)
		,
		
		armorTest2: new Item("Stupid Armor", ITEM_TYPE.ARMOR)
			.setUsedBy(CHAR.NILS)
			.setSprite(sLaughingCryingEmoji)
			.setDesc("POOPY ASS ARMOR")
			.setStats(1,,,,,4,,1)
			.setDefTypes([MOVE_TYPE.PHYS])
			.setFunc(equipArmor)
			.setDraw(drawItem)
		,
		
		burger: new Item("Burger", ITEM_TYPE.CONSUMABLE)
			.setSprite(sItemBurger)
			.setFunc(consume)
			.setValue(20)
		,
			
		//burgerOLD:
		//{
			//category : ITEM_TYPE.CONSUMABLE,
			//heal : 20,
			//sprite : sItemBurger,
			//name: "Cheeseburger",
			//type : "item",
			//desc: "Heals 20 hp to one target",
			//targetRequired : true,
			//targetEnemyByDefault: false,
			//targetAll : MODE.NEVER,
			//userAnimation : "attack",
			//fxSprite : sHeal,
			//effectOnTarget: MODE.ALWAYS,
			//hitSound : snHealMinor,
			//tags : [FOOD_TAG.DAIRY,FOOD_TAG.GRAIN,FOOD_TAG.MEAT],
			//func : heal
		//},
			
		//keyGeneric	: new create_item(
			//ITEM_TYPE.KEY,
			//"Small Key", 
			//"Unlocks regular doors.", 
			//sItemKeyGeneric),
	}
	
	struct_foreach(global.items, function(_key, _val){
	  _val[$ "key"] = _key  
	  if _val[$ "category"] == ITEM_TYPE.CONSUMABLE {_val[$ "submenu"] = "Items"}
	})
	
}
	
function equipArmor(user = global.characters[CHAR.NILS], targets = global.characters[CHAR.NILS], source = -1)
{
	var me = global.items[$ self.key ]
	var users = me[$ "usedBy"];
	
	if users != undefined { if !is_array(users){ users = [users]} }
	
	if users == undefined or array_contains(users,array_get_index(global.characters,user)){
		
		var slot = global.currentEquipMenu
		//if slot.equip != noone{ // Replace equip slot with new one
			//addItem(global.items[$ user.equips.armor ], false);
			//user.equips.armor = noone;
		//}
		
		//equip item as key
		user.equips[slot].equip = self.key;
		
		// update the sprite in the equip menu slots
		var menuItem = other.options[$ user.name][global.currentEquipMenu]
		menuItem.value = self.key
		
		shortMessage($"//Equipped [c_red]{me.name}!",TXTPOS.MID)
		show_debug_message($"{user.name} EQUIPPED {me.name}.");
	}
}

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
		var itemKey = item.key;
	
		array_push(global.inv[_item.category],itemKey);
	
		if _showMsg { SFX snCaveStoryGetItem; shortMessage($"//Found a [c_red]{_item.name}[c_white]!",TXTPOS.MID) }
		show_debug_message($"Added Item: {_item.name} to Inventory")
		return true;
	}
	
	shortMessage($"//You don't have room for this [c_red]{_item.name}[c_white].",TXTPOS.MID)
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
		textbox.setText($"//Found a {item.name}!")
	}
}



