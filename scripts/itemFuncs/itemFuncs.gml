

///@param {string} Name 
///@param {string} Desc 
///@param {Enum.ITEM_TYPE} Type 
function Item(_name = "", _desc = "", _type = ITEM_TYPE.KEY) : IMenuable() constructor {
	
	//ARMOR
	name = _name;
	desc = _desc;
	itemType = _type;
	usedBy = global.party;
    equipped = noone;
    sound = snHealMinor;
    
    //ATTACK traits
    submenu = -2;
    targetRequired = true;
    targetEnemyByDefault = false;
    targetAll = MODE.NEVER;
    
    userAnimation = "idle";
    fxSprite = sBlank;
    effectOnTarget = MODE.ALWAYS;
    hitSound = noone;
    
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
    
    draw = drawItem;
    switch(itemType){
        case ITEM_TYPE.CONSUMABLE: func = consume; submenu = "Items" break;
        case ITEM_TYPE.ARMOR: func = equipArmor break;
        case ITEM_TYPE.WEAPON: func = equipArmor break;
        case ITEM_TYPE.MOD: func = equipArmor break;
        case ITEM_TYPE.KEY: break;
    }

	static setSprite = function(v){ sprite = v; return self; };

	///@param {Enum.CHAR,array<Enum.CHAR>} Users Characters object is equippable by. 
	///@desc Sets constraint of which party members can equip item. 
	/// Takes either a CHAR enum or array of CHAR enums.
	/// Can be left empty to not set a User constraint.
	static setUsedBy = function(v){ usedBy = is_array(v) ? v : [v]; return self; };
		
	///@param {real} Lvl Level Requirement
	///@param {real} Exp Bonus Exp Gain (percentage)
	///@param {real} Hp Bonus Hp Gain (percentage)
	///@param {real} HpMax Bonus Max Health
	///@param {real} Str Adds To Stat
	///@param {real} Def Adds To Stat
	///@param {real} ExStr Adds To Stat
	///@param {real} ExDef Adds To Stat
	///@param {real} Int Adds To Stat
	///@param {real} Spd Adds To Stat
	///@param {real} Cha Adds To Stat
	///@param {real} Luck Adds To Stat
	
	///@desc Sets all stat bonuses.
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
        
        if is_struct(lvl){
                
            stats = variable_clone(lvl);
            return self;
        }
        
		setLvl(lvl);
		setEXP(EXP);
		setHp(hp);
		setHpMax(hpMax);
	
		setStr(str);
		setDef(def);
		setExStr(exStr);
		setExDef(exDef);
	
		setInt(int);
		setSpd(spd);
		setCha(cha);
		setLuk(luk);
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

	/// @param {Enum.MOVE_TYPE,array<Enum.MOVE_TYPE>} Type Damage type
	/// @desc Sets damage type of Move, or damage type bonus of Equip.
	/// Takes either a MOVE_TYPE enum or array of MOVE_TYPE enums.
	static setAtkTypes = function(v){ atkTypes = is_array(v) ? v : [v]; infoCard.types = atkTypes; return self; };
	
	/// @param {Enum.MOVE_TYPE,array<Enum.MOVE_TYPE>} Type Damage type resistance
	/// @desc Sets resistance to damage type for Equip.
	/// Takes either a MOVE_TYPE enum or array of MOVE_TYPE enums.
	static setDefTypes = function(v){ defTypes = is_array(v) ? v : [v]; return self; };
	
	/// @param {Enum.FOOD_TAG,array<Enum.FOOD_TAG>} Type Consumable food type
	/// @desc Sets food type of consumable.
	/// Takes either a FOOD_TAG enum or array of FOOD_TAG enums.
	static setTags = function(v){ tags = is_array(v) ? v : [v]; infoCard.tags = tags; return self; };
	
    static setSound = function(v){ sound = v; return self; };

}



#region item function archetypes

	function consume(user, targets = [NILS]) { 
		
		item = global.items[$ self.key];
		var _val = item.value;
		var _type = item.itemType;
		
		if instance_exists(oBattle) {
			
            global.CurrentConsumable = targets[0]
            battleChangeHP(targets[0],_val,0)
            struct_foreach(targets[0].allergies,function(key,value){
                if array_contains(other.tags,key) assignStatus(global.CurrentConsumable,value);
            })
		} 
		else {
            
			global.CurrentConsumable = item;
            if array_length(PARTY) > 1 { createConsumeMenu() } else battleChangeHP(PARTY[0], global.CurrentConsumable.value,,global.CurrentConsumable.sound,true,false)
		}
		
        if DEV exit;
		var me = array_get_index(global.inv[_type],item);
		array_delete(global.inv[_type],me,1);
	}


#endregion

function initItems(){
	
	global.inv[ITEM_TYPE.CONSUMABLE] = [];
	global.inv[ITEM_TYPE.ARMOR] = [];
	global.inv[ITEM_TYPE.MOD] = [];
	global.inv[ITEM_TYPE.WEAPON] = [];
	global.inv[ITEM_TYPE.KEY] = [];
	
	global.items = 
	{
		unequip: new Item("None")
			.setFunc(function(){equipArmor(,,false)})
            .setDraw(function(){})
		,
		armorTest: new Item("Basic Armor", "SHITTY ASS ARMOR", ITEM_TYPE.ARMOR)
			.setUsedBy(NILS)
			.setSprite(sHeadNils)
			.setStats(1,,,,,4,,1)
			.setDefTypes([MOVE_TYPE.PHYS])
		,
		
		armorTest2: new Item("Stupid Armor", "POOPY ASS ARMOR", ITEM_TYPE.ARMOR)
			.setUsedBy(NILS)
			.setSprite(sLaughingCryingEmoji)
			.setStats(1,,,,,4,,1)
			.setDefTypes([MOVE_TYPE.PHYS])
		,
        
        weaponTest: new Item("Basic Weapon", "SHITTY ASS WEAPON", ITEM_TYPE.WEAPON)
			.setSprite(sBattleEnemySkull)
			.setStr(4)
		,
        
        weaponTest2: new Item("Dumb Weapon", "POOPY ASS WEAPON", ITEM_TYPE.WEAPON)
			.setSprite(sCharWalkD)
			.setStr(6)
		,
		
		burger: new Item("Burger", "Heals you 20 hp", ITEM_TYPE.CONSUMABLE)
			.setSprite(sItemBurger)
            .setTags([FOOD_TAG.SPICY, FOOD_TAG.SHELLFISH])
			.setValue(20)
		,
		
		keyGeneric: new Item("Small Key")
            .setSprite(sItemKeyGeneric)
	}
	
	struct_foreach(global.items, function(_key, _val){
		_val[$ "key"] = _key  
		if _val[$ "type"] == ITEM_TYPE.CONSUMABLE {_val[$ "submenu"] = "Items"} 
        if DEV addItem(_val,false)
	})
	
}
	
function equipArmor(user = global.currentMenuUser, source = -1, _message = true)
{
    if !instance_exists(oPauseMenu){ if _message {shortMessage("//You can't do that right now.", TXTPOS.MID)}; return false;}
    
	var me = global.items[$ self.key ]
	var users = me[$ "usedBy"];
	
	if users != undefined { if !is_array(users){ users = [users]} }
	
	if users == undefined or array_contains(users,user){
		
		var slot = global.currentEquipMenu
		var equipment = global.items[$ user.equips[slot].equip ]
        
        //TODO: Make equip stripping work
        // if you take an equip that someone else was using, strip it from them
        if equipment != undefined and global.characters[$ equipment.equipped].equips != noone {
            global.characters[$ equipment.equipped].equips[global.currentEquipMenu].equip = global.items.unequip;
        }
        
        // tell old equipment its not longer equipped
        if equipment != undefined {
            equipment.equipped = noone
        }
        
		//equip new item as key
		user.equips[slot].equip = key;
        equipped = user.name;
		
		// update the sprite in the equip menu slots
		var menuItem = other.options[$ user.name][global.currentEquipMenu]
		menuItem.value = key
		menuItem.sprite = sprite
		
		if _message {
			shortMessage($"//Equipped [c_red]{me.name}!",TXTPOS.MID)
			AFTERTEXT{with oPauseMenu doGoBack()}
		} else {
			with oPauseMenu {doGoBack()}
		}
		
		show_debug_message($"{user.name} EQUIPPED {me.name}.");
	}
    
    return true;
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
	if array_length(global.inv[_item.itemType]) < global.invSize
	{
		item = _item
		var itemKey = item.key;
	
		array_push(global.inv[_item.itemType],itemKey);
	
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



