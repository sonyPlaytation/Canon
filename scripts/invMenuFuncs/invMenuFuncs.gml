
function createItemMenu(invType = itemType, key = label)
{
	items = []
	other.options[$ key] = []
	array_foreach(global.inv[invType],function(element, index)
	{
		var theItem = global.items[$ element];
		var _item =
		{
			key : element,
			allowed : true,
			type : "item",
			label : theItem.name,
			func : theItem.func
		}
				
		array_push(other.items,_item)
	})
	
	var len = array_length(items)
	array_copy(other.options[$ key],0,items,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	enterSubmenu(key);
}

// entering character equip slots menu. itemizes slots for use in menu page
function createEquipSlotMenu(guy = global.characters[CHAR.NILS])
{
	other.currentUser = guy
	var key = guy.name;

	equipslots = [];
	other.options[$ key] = []
	array_foreach(guy.equips,function(element, index)
	{
		global.currentlyEquipped[index] = global.items[$ element.equip]
		var _slot =
		{
			key : nameof(element),
			allowed : true,
			type : "submenu",
			itemType : element.type,
			label : element.label,
			slotIndex : index,
			func : function(){ createItemMenu(itemType,label); global.currentEquipMenu = slotIndex },
			value : element.equip,
			draw : drawItem
		}
		_slot.value = element.equip;
		equipslots[index] = _slot;
	})
	
	var len = array_length(equipslots)
	array_copy(other.options[$ key],0,equipslots,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	enterSubmenu(key);
}

//function createEquipMenu(invType = itemType)
//{
	//// turn character equip struct into an array for compatability with menu system
	//equips = [];
	//equipslots = [];
	//
	//other.options[$ guy.name] = equips
	//array_foreach(equips,function(element, index)
	//{
		//var _item =
		//{
			//key : element.key,
			//allowed : true,
			//type : "equipment",
			//label : element.name,
			//func : equipArmor
		//}
				//
		//array_push(other.items,_item)
	//})
	//
	//var len = array_length(items)
	//array_copy(other.options[$ key],0,items,0,len);
	//array_push(other.options[$ key],variable_clone(other.goBack))
	//enterSubmenu(key);
//}

function enterSubmenu(_menuName = label)
{
	with oPauseMenu
	{
		array_push(prevMenus,
		{
			menu : currentMenu,
			hover : hover
		}) 
		currentMenu = _menuName	
		hover = 0;
	}
}

function doGoBack()
{
    saveSettings()
	with oPauseMenu
	{
		var _struct = array_pop(prevMenus)
		currentMenu = _struct.menu;
		hover = _struct.hover;
	}
}

function drawToggle(_x, _y, _active = false, _value = value){
    
    var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    
    draw_text(xx,yy,_value)
    
    updatevolume()
}

function drawSlider(_x, _y, active = false, _value = value, _scale = scale){
    
    draw_set_halign(fa_middle)
    
    var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    var space = TILE_SIZE*0.75
    var val = round(_value*_scale)/_scale
    
    var col = c_dkgrey
    if active {col = c_white}
    
    // backing box
    draw_set_color(col)
    draw_sprite_ext(sBattleEXCost,active,xx+space-10,yy-8,1,1,0,col,1)
    draw_sprite_ext(sSettingsArrow,0,xx - (3*active*other.left),yy+1,1,1,0,col,1)
    draw_sprite_ext(sSettingsArrow,1,xx+(space*2) + (3*active*other.right),yy+1,1,1,0,col,1)
    
    // text
    draw_set_color(c_black)
    draw_text(xx+space-1,yy,floor(val*_scale))
    draw_text(xx+space,yy+1,floor(val*_scale))
    draw_text(xx+space-1,yy+1,floor(val*_scale))
    
    if active {col = c_highlight} else col = c_white
    draw_set_color(col)
    draw_text(xx+space,yy,val*_scale)
    
    updatevolume()
}

function drawItem(_x, _y, _active = false, _value = value){
	
	var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    var space = TILE_SIZE*0.75
	
	draw_sprite_ext(sBattleEXCost,_active,xx,yy-8,1,1,0, _active ? c_white : c_dkgrey, 1)
	
	if is_undefined(_value) or _value == noone exit;
	
	var sprite = global.items[$ _value].sprite
	draw_sprite(sprite, 0, xx + (sprite_get_width(sBattleEXCost)/2)-1 + (sprite_get_width(sprite)mod 2 == 0), yy)
	
}