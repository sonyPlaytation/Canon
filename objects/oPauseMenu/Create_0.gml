/// @
global.pauseEvery = true;
loadSettings()
oPlayer.JustHitEnemyButCanStillMoveALittle = 0;
oInputReader.alphaTarg = 0;
depth = -9999
hover = 0;
active = true;
subMenuLevel = 0;
actorName = ""
InputVerbConsume(INPUT_VERB.CANCEL);

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
canDestroy = false;
destroyMenu = false
alarm[1] = 10;

currentMenu = "Menu"
prevMenus = []
options = {}

alpha = 0;
alphaTarg = 0.5;

down = InputPressed(INPUT_VERB.DOWN);
up = InputPressed(INPUT_VERB.UP);
left = InputPressed(INPUT_VERB.LEFT);
right = InputPressed(INPUT_VERB.RIGHT);
accept = InputPressed(INPUT_VERB.ACCEPT);

vert = down - up;
hort = right - left;

downFrames = 0;
upFrames = 0;
leftFrames = 0;
rightFrames = 0;

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
		allowed : FLAGS.playerName != "???",
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
			other.enterSubmenu("Equip");	
		}
	},
	
	{
		allowed : FLAGS.playerName != "???",
		type : "submenu",
		label : "Party",
		func : function(){
			
			guys = []
			other.options[$ label] = guys
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
			array_copy(other.options[$ label],0,guys,0,len);
			array_push(other.options[$ label],variable_clone(other.goBack))
			other.enterSubmenu(label);	
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
    itemType : ITEM_TYPE.CONSUMABLE,
	func : createItemMenu
})	

if array_length(global.inv[ITEM_TYPE.WEAPON]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Weapons",
		itemType : ITEM_TYPE.WEAPON,
        func : createItemMenu
	})	
}

if array_length(global.inv[ITEM_TYPE.ARMOR]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Armor",
		itemType : ITEM_TYPE.ARMOR,
        func : createItemMenu
	})	
}

if array_length(global.inv[ITEM_TYPE.MOD]) != 0
{
	array_push(options[$ "Item"],
	{
		allowed : true,
		type : "submenu",
		label : "Gems",
		itemType : ITEM_TYPE.MOD,
        func : createItemMenu
	})	
}

array_push(options[$ "Item"],
{
	allowed : true,
	type : "submenu",
	label : "Key Items",
	itemType : ITEM_TYPE.KEY,
	func : createItemMenu
})	

array_push(options[$ "Item"],variable_clone(goBack))
#endregion

options[$ "System"] = 
[
	{
		allowed : true,
		type : "submenu",
		label : "Save",
		func : function(){ instance_destroy(other) saveGame()}
	},

	{
		allowed : true,
		type : "submenu",
		label : "Load",
		func : function(){ instance_destroy(other) loadGame(true)}
	},

	{
		allowed : true,
		type : "submenu",
		label : "Settings",
		func : enterSubmenu
	},

	{
		allowed : true,
		type : "submenu",
		label : "Main Menu",
		func : function(){ if show_question("Are you sure?") global.pauseEvery = false; game_restart() }
	},

	{
		allowed : true,
		type : "submenu",
		label : "Close Game",
		func : function(){ if show_question("Are you sure?") game_end() }
	},

	variable_clone(goBack)
	
]

options[$ "Settings"] =
[
    {
		allowed : true,
		type : "submenu",
		label : "Audio",
		func : enterSubmenu
	},
    
	{
		allowed : true,
		type : "submenu",
		label : "Video",
		func : enterSubmenu
	},
    
    {
		allowed : true,
		type : "submenu",
		label : "Other",
		func : enterSubmenu
	},

	variable_clone(goBack)
]

options[$ "Audio"] =
[
    {
		allowed : true,
		type : "toggle",
		label : "Toggle Mute",
        value : global.settings.sound.mute,
		func : function(){ 
            global.settings.sound.mute = !global.settings.sound.mute; 
            value = global.settings.sound.mute 
        },
        draw : toggle
	},
    
	{
		allowed : true,
		type : "slider",
		label : "Master Volume",
        value : global.settings.sound.masterVolume,
		func : function(){ 
            value = clamp(global.settings.sound.masterVolume+(other.hort/10),0,1)
            global.settings.sound.masterVolume = value;
        },
        scale : 10,
        draw : slider
	},
    
    {
		allowed : true,
		type : "slider",
		label : "Music Volume",
        value : global.settings.sound.musicVolume,
		func : function(){ 
            value = clamp(global.settings.sound.musicVolume+(other.hort/10),0,1)
            global.settings.sound.musicVolume = value;
        },
        scale : 10,
        draw : slider
	},
    
    {
		allowed : true,
		type : "slider",
		label : "SFX Volume",
        value : global.settings.sound.sfxVolume,
		func : function(){ 
            value = clamp(global.settings.sound.sfxVolume+(other.hort/10),0,1)
            global.settings.sound.sfxVolume = value;
        },
        scale : 10,
        draw : slider
	},
    
    {
		allowed : true,
		type : "slider",
		label : "Voice Volume",
        value : global.settings.sound.voiceVolume,
		func : function(){ 
            value = clamp(global.settings.sound.voiceVolume+(other.hort/10),0,1)
            global.settings.sound.voiceVolume = value;
        },
        scale : 10,
        draw : slider
	},

	variable_clone(goBack)
]

options[$ "Video"] =
[
    {
		allowed : true,
		type : "toggle",
		label : "Fullscreen",
        value : global.window_mode == STANNCAM_WINDOW_MODE.BORDERLESS,
		func : function(){ 
            
            SETTINGS.video.fullscreen = toggleFullscreen(); 
            value = SETTINGS.video.fullscreen
            other.options[$ "Video"][1].allowed = !SETTINGS.video.fullscreen
        },
        draw : toggle
	},
    
    {
		allowed : !SETTINGS.video.fullscreen,
		type : "slider",
		label : "Int Scale",
        value : stanncam_get_res_scale_x(),
		func : function(){ 
            
            SETTINGS.video.scale = clamp(SETTINGS.video.scale+(other.hort),1,6)
            value = SETTINGS.video.scale
            if other.hort != 0 {
                stanncam_set_resolution(GAME_W*SETTINGS.video.scale,GAME_H*SETTINGS.video.scale);
                window_center()
            }
        },
        scale : 1,
        draw : slider
	},

	variable_clone(goBack)
]

options[$ "Other"] =
[
    {
		allowed : true,
		type : "slider",
		label : "Text Speed",
        value : SETTINGS.other.textspeed,
		func : function(){ 
            value = clamp(SETTINGS.other.textspeed+(other.hort/10),0,1)
            SETTINGS.other.textspeed = value;
        },
        scale : 10,
        draw : slider
	},
    
    {
		allowed : true,
		type : "toggle",
		label : "Input Display",
        value : SETTINGS.other.inputDisplay,
		func : function(){ 
            
            SETTINGS.other.inputDisplay = !SETTINGS.other.inputDisplay; 
            value = SETTINGS.other.inputDisplay
        },
        draw : toggle
	},
    
    {
		allowed : true,
		type : "toggle",
		label : "Dash Alert",
        value : SETTINGS.other.dashCooldown,
		func : function(){ 
            
            SETTINGS.other.dashCooldown = !SETTINGS.other.dashCooldown; 
            value = SETTINGS.other.dashCooldown
        },
        draw : toggle
	},

	variable_clone(goBack)
]

if DEV array_insert(options[$ "Settings"], 0,
    {
        allowed : DEV,
        type : "submenu",
        label : "Toggle Debug",
        func : function(){ global.debug = !global.debug }
    }
)

function createItemMenu(invType = itemType, key = label)
{
	items = []
	other.options[$ key] = items
	array_foreach(global.inv[invType],function(element, index)
	{
		var theItem = global.items[$ element];
		var _item =
		{
			key : element,
			allowed : true,
			type : "item",
			label : theItem.name,
			func : theItem.func // TODO: change pause menu to tak references to structs
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
    saveSettings()
	var _struct = array_pop(other.prevMenus)
	other.currentMenu = _struct.menu;
	other.hover = _struct.hover;
}

function toggle(_x, _y, _active = false, _value = value){
    
    var xx = _x + (TILE_SIZE*5);
    var yy = _y;
    
    draw_text(xx,yy,_value)
    
    updatevolume()
}

function slider(_x, _y, active = false, _value = value, _scale = scale){
    
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