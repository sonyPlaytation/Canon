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
				oPauseMenu.CurrentElement = element
				var _guy =
				{
					allowed : true,
					type : "submenu",
					label : element.name,
					func : createEquipSlotMenu
				}
				
				array_push(other.guys,_guy)
			})
	
			var len = array_length(guys)
			array_copy(other.options[$ "Equip"],0,guys,0,len);
			array_push(other.options[$ "Equip"],variable_clone(oPauseMenu.goBack))
			with oPauseMenu enterSubmenu("Equip");	
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
			array_push(other.options[$ label],variable_clone(oPauseMenu.goBack))
			enterSubmenu(label);	
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
//
//if array_length(global.inv[ITEM_TYPE.WEAPON]) != 0
//{
	//array_push(options[$ "Item"],
	//{
		//allowed : true,
		//type : "submenu",
		//label : "Weapons",
		//itemType : ITEM_TYPE.WEAPON,
        //func : createItemMenu
	//})	
//}
//
//if array_length(global.inv[ITEM_TYPE.ARMOR]) != 0
//{
	//array_push(options[$ "Item"],
	//{
		//allowed : true,
		//type : "submenu",
		//label : "Armor",
		//itemType : ITEM_TYPE.ARMOR,
        //func : createItemMenu
	//})	
//}
//
//if array_length(global.inv[ITEM_TYPE.MOD]) != 0
//{
	//array_push(options[$ "Item"],
	//{
		//allowed : true,
		//type : "submenu",
		//label : "Gems",
		//itemType : ITEM_TYPE.MOD,
        //func : createItemMenu
	//})	
//}

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
        draw : drawToggle
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
        draw : drawSlider
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
        draw : drawSlider
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
        draw : drawSlider
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
        draw : drawSlider
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
        draw : drawToggle
	},
    
    {
		allowed : !SETTINGS.video.fullscreen,
		type : "slider",
		label : "Int Scale",
        value : SETTINGS.video.scale,
		func : function(){ 
            
            SETTINGS.video.scale = clamp(SETTINGS.video.scale+(other.hort),1,6)
            value = SETTINGS.video.scale
            if other.hort != 0 {
                stanncam_set_resolution(GAME_W*SETTINGS.video.scale,GAME_H*SETTINGS.video.scale);
                window_center()
            }
        },
        scale : 1,
        draw : drawSlider
	},
	
	{
		allowed : true,
		type : "slider",
		label : "Camera Spd",
        value : SETTINGS.video.camSpd,
		func : function(){ 
            
            SETTINGS.video.camSpd = clamp(SETTINGS.video.camSpd+(other.hort),1,5)
            value = SETTINGS.video.camSpd;
			global.cam.spd = SETTINGS.video.camSpd+3;
        },
        scale : 1,
        draw : drawSlider
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
        draw : drawSlider
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
        draw : drawToggle
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
        draw : drawToggle
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

controls = function(){
	
	if instance_exists(oTextBox){
		
		down = false
		up = false
		left = false
		right = false
		accept = false
		back = false
		close = false
		exit;
	} 
		
	down = InputPressed(INPUT_VERB.DOWN);
	up = InputPressed(INPUT_VERB.UP);
	left = InputPressed(INPUT_VERB.LEFT);
	right = InputPressed(INPUT_VERB.RIGHT);
	accept = InputPressed(INPUT_VERB.ACCEPT);
	back = InputPressed(INPUT_VERB.CANCEL)
	close = (InputPressed(INPUT_VERB.PAUSE) or InputPressed(INPUT_VERB.SKIP))
	
	if InputCheck(INPUT_VERB.DOWN) {downFrames++} else downFrames = 0;
	if InputCheck(INPUT_VERB.UP) {upFrames++} else upFrames = 0;
	if InputCheck(INPUT_VERB.LEFT) {leftFrames++} else leftFrames = 0;
	if InputCheck(INPUT_VERB.RIGHT) {rightFrames++} else rightFrames = 0;
	
	var frameTarg = 20;
	if downFrames == frameTarg {down = true; downFrames = frameTarg*0.75}
	if upFrames == frameTarg {up = true; upFrames = frameTarg*0.75}
	if leftFrames == frameTarg {left = true; leftFrames = frameTarg*0.75}
	if rightFrames == frameTarg {right = true; rightFrames = frameTarg*0.75}
	
	vert = down - up;
	hort = right - left;
}