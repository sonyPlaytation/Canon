/// @
global.pauseEvery = true;
oPlayer.JustHitEnemyButCanStillMoveALittle = 0;
oInputReader.alphaTarg = 0;
depth = -9999
hover = 0;
active = true;
subMenuLevel = 0;
actorName = ""

x = -120
xTarg = 0
lerpSpd = 0.25;
y = 0
yOffset = 0;
menuGap = 6

lineHeight = 19;
height = 0
heightFull = 0
xmargin = 12;
ymargin = 8

selectY = y;
destroyMenu = false

currentMenu = "Menu"
prevMenus = []
options = {}

goBack = 
{
	allowed : true,
	type : "submenu",
	label : "Back",
	func : doGoBack
}

options[$ "Menu"] = 
[
	{
		allowed : true,
		type : "submenu",
		label : "Item",
		func : enterSubmenu
	},
	
	{
		allowed : true,
		type : "submenu",
		label : "Equip",
		func : function(){
			
			guys = []
			other.options[$ "Equip"] = guys
			array_foreach(PARTY,function(element, index)
			{
				var _guy =
				{
					allowed : true,
					type : "submenu",
					label : element.name,
					func : undefined
				}
				
				array_push(other.guys,_guy)
			})
	
			var len = array_length(guys)
			array_copy(other.options[$ "Equip"],0,guys,0,len);
			array_push(other.options[$ "Equip"],variable_clone(other.goBack))
			enterSubmenu("Equip");	
		}
	},
	
	{
		allowed : true,
		type : "submenu",
		label : "Party",
		func : function(){
			
			guys = []
			other.options[$ "Equip"] = guys
			array_foreach(PARTY,function(element, index)
			{
				var _guy =
				{
					allowed : true,
					type : "submenu",
					label : element.name,
					func : undefined
				}
				
				array_push(other.guys,_guy)
			})
	
			var len = array_length(guys)
			array_copy(other.options[$ "Equip"],0,guys,0,len);
			array_push(other.options[$ "Equip"],variable_clone(other.goBack))
			enterSubmenu("Equip");	
		}
	},
	
	{
		allowed : true,
		type : "submenu",
		label : "System",
		func : enterSubmenu
	},
]

#region set items menu based on which items you have currently
//TODO: probably make separate objects for displaying items in.
options[$ "Item"] =  []

array_push(options[$ "Item"],
{
	allowed : true,
	type : "submenu",
	label : "Consumables",
	func : function() {createItemMenu(ITEM_TYPE.CONSUMABLE)}
})	

if array_length(global.inv[ITEM_TYPE.WEAPON]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Weapons",
		func : function() {createItemMenu(ITEM_TYPE.WEAPON)}
	})	
}

if array_length(global.inv[ITEM_TYPE.ARMOR]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Armor",
		func : function() {createItemMenu(ITEM_TYPE.ARMOR)}
	})	
}

if array_length(global.inv[ITEM_TYPE.MOD]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Gems",
		func : function() {createItemMenu(ITEM_TYPE.MOD)}
	})	
}


array_push(options[$ "Item"],
{
	allowed : true,
	type : "submenu",
	label : "Key Items",
	func : function() {createItemMenu(ITEM_TYPE.KEY)}
})	

array_push(options[$ "Item"],variable_clone(goBack))
#endregion


function createItemMenu(invType = ITEM_TYPE.CONSUMABLE, key = label)
{
	items = []
	other.options[$ key] = items
	array_foreach(global.inv[invType],function(element, index)
	{
		var _item =
		{
			allowed : true,
			type : "item",
			label : element.name,
			func : undefined // TODO: define Menu Functions within the item structs
		}
				
		array_push(other.items,_item)
	})
	
	var len = array_length(items)
	array_copy(other.options[$ key],0,items,0,len);
	array_push(other.options[$ key],variable_clone(other.goBack))
	enterSubmenu(key);
}

function enterSubmenu(_menuName = label)
{
	array_push(other.prevMenus,
	{
		menu : other.currentMenu,
		hover : other.hover
	}) 
	other.currentMenu = _menuName	
	other.hover = 0;
}

function doGoBack()
{
	var _struct = array_pop(other.prevMenus)
	other.currentMenu = _struct.menu;
	other.hover = _struct.hover;
}