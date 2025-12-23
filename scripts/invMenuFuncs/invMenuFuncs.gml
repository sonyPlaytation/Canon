
function createItemMenu(invType = itemType, key = name)
{
	items = []
	other.options[$ key] = []
	array_foreach(global.inv[invType],function(element, index)
	{
		var theItem = global.items[$ element];

		array_push(other.items,theItem)
	})
	
	var len = array_length(items)
	array_copy(other.options[$ key],0,items,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	enterSubmenu(key);
}

function createPartyNamesMenu()
{
	guys = []
	other.options[$ "Equip"] = guys
	array_foreach(PARTY,function(element, index)
	{
		oPauseMenu.CurrentElement = element
		oPauseMenu.CurrentIndex = index
		var _guy = new IMenuable(element.name)
			.setType("submenu")
			.setFunc(function(){createEquipSlotMenu(name)})
		;
		
		array_push(other.guys,_guy)
	})

	var len = array_length(guys)
	//array_copy(other.options[$ "Equip"],0,guys,0,len);
	array_push(other.options[$ "Equip"],variable_clone(oPauseMenu.goBack))
	with oPauseMenu enterSubmenu("Equip");
}

function createConsumeMenu()
{
	guys = []
    menu = "Consume"
	other.options[$ menu] = guys
	array_foreach(PARTY,function(element, index)
	{
		oPauseMenu.CurrentElement = element
		oPauseMenu.CurrentIndex = index
		var _guy = new IMenuable(element.name)
			.setType("submenu")
			.setFunc(function(){battleChangeHP(global.characters[$ name] ,global.CurrentConsumable.value,,global.CurrentConsumable.sound,true,true)})
            .setDraw(drawHead)
		;
		
		array_push(other.guys,_guy)
	})

	var len = array_length(guys)
	array_copy(other.options[$ menu],0,guys,0,len);
	array_push(other.options[$ menu],variable_clone(oPauseMenu.goBack))
	with oPauseMenu enterSubmenu(other.menu);
}

// entering character equip slots menu. itemizes slots for use in menu page
function createEquipSlotMenu(_key = "Nils")
{
	var key = _key;
	var guy = global.characters[$ key]
	global.currentMenuUser = guy
	
	equipslots = [];
	other.options[$ key] = []
	array_foreach(guy.equips,function(element, index)
	{
		global.currentlyEquipped[index] = global.items[$ element.equip]
		var _slot = {

			key : nameof(element),
			allowed : true,
			menuType : "submenu",
			itemType : element.type,
			name : element.label,
			slotIndex : index,
			func : function(){ createEquipMenu(self.itemType,self.name); global.currentEquipMenu = self.slotIndex },
			value : element[$ "equip"],
			sprite : (element.equip == noone) ? sBlank : global.items[$ element.equip][$ "sprite"],
			draw : drawSlot
		}
		_slot.value = element.equip;
		equipslots[index] = _slot;
	})
	
	var len = array_length(equipslots)
	array_copy(other.options[$ key],0,equipslots,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	enterSubmenu(key);
}

function createEquipMenu(invType = itemType, key = name)
{
	items = []
	other.options[$ key] = []
	array_foreach(global.inv[invType],function(element, index)
	{
		var theItem = global.items[$ element];
        with theItem { setAllowed((stats.lvl <= global.currentMenuUser.stats.lvl) and array_contains(usedBy,global.currentMenuUser) and equipped != global.currentMenuUser.name) }

		array_push(other.items,theItem)
	})
	
	var len = array_length(items)
	array_copy(other.options[$ key],0,items,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	array_insert(other.options[$ key],0, global.items.unequip)
	enterSubmenu(key);
}

function enterSubmenu(_menuName = name)
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

function drawItem(_x, _y, _active = false){
	
	var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    var space = TILE_SIZE*0.75
	
	draw_sprite_ext(sBattleEXCost,_active,xx,yy-8,1,1,0, _active ? c_white : c_dkgrey, 1)
	if is_undefined(value) or value == noone exit;
	
	if !is_undefined(sprite) draw_sprite(sprite, 0, xx + (sprite_get_width(sBattleEXCost)/2)-1 + (sprite_get_width(sprite)mod 2 == 0), yy)
        
    if equipped != noone draw_sprite(global.characters[$ equipped].sprites.head,0,xx + 36 ,yy)
	
}

function drawHead(_x, _y, _active = false){
	
	var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    var space = TILE_SIZE*0.75
    
    var sprite = global.characters[$ name].sprites.head;
	
	if !is_undefined(sprite) draw_sprite_ext(sprite, 0, xx + (sprite_get_width(sBattleEXCost)/2)-1 + (sprite_get_width(sprite)mod 2 == 0), yy,1,1,0,_active ? c_white : c_dkgrey, 1)
	
}

function drawSlot(_x, _y, _active = false){
	
	var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    var space = TILE_SIZE*0.75
	
	draw_sprite_ext(sMenuItemFrame,_active,xx,yy-8,1,1,0, _active ? c_white : c_dkgrey, 1)
	if is_undefined(value) or value == noone exit;
	
	if !is_undefined(sprite) draw_sprite(sprite, 0, xx + (sprite_get_width(sBattleEXCost)/2) + (sprite_get_width(sprite)mod 2 == 0), yy)
	
}