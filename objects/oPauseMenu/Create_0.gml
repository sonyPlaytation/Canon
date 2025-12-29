/// @

#macro MENU new IMenuable

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

goBack = new IMenuable("Back").setFunc(doGoBack);

options[$ "Menu"] =  [
	
    MENU("Item")
	.setFunc(enterSubmenu),
	
	MENU("Equip")
	.setAllowed(FLAGS.playerName != "???")
	.setFunc(createPartyNamesMenu),
    
	MENU("Party")
	.setAllowed(FLAGS.playerName != "???"),
	
	MENU("System")
	.setFunc(enterSubmenu),
]

#region set items menu based on which items you have currently
//TODO: probably make separate objects for displaying items in.
options[$ "Item"] =  []

array_push(options[$ "Item"],
MENU("Consumables")
.setType("submenu")
.setItemType(ITEM_TYPE.CONSUMABLE)
.setFunc(createItemMenu)
)	

//
//if array_length(global.inv[ITEM_TYPE.WEAPON]) != 0
//{
	//array_push(options[$ "Item"],
	//{
		//allowed : true,
		//menuType : "submenu",
		//name : "Weapons",
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
		//menuType : "submenu",
		//name : "Armor",
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
		//menuType : "submenu",
		//name : "Gems",
		//itemType : ITEM_TYPE.MOD,
        //func : createItemMenu
	//})	
//}

array_push(options[$ "Item"],
{
	allowed : true,
	menuType : "submenu",
	name : "Key Items",
	itemType : ITEM_TYPE.KEY,
	func : createItemMenu
})	

array_push(options[$ "Item"],variable_clone(goBack))
#endregion

options[$ "System"] =  [
	
    {
		allowed : array_contains(PARTY,MATTHEW),
		menuType : "submenu",
		name : "Save",
		func : function(){ instance_destroy(other) saveGame()}
	},

	{
		allowed : file_exists(SAVEFILE),
		menuType : "submenu",
		name : "Load",
		func : function(){ instance_destroy(other) loadGame(true)}
	},

	{
		allowed : true,
		menuType : "submenu",
		name : "Settings",
		func : enterSubmenu
	},

	{
		allowed : true,
		menuType : "submenu",
		name : "Main Menu",
		func : function(){ if show_question("Are you sure?") global.pauseEvery = false; game_restart() }
	},

	{
		allowed : true,
		menuType : "submenu",
		name : "Close Game",
		func : function(){ if show_question("Are you sure?") game_end() }
	},

	variable_clone(goBack)
	
]

options[$ "Settings"] = [
    
    {
		allowed : true,
		menuType : "submenu",
		name : "Audio",
		func : enterSubmenu
	},
    
	{
		allowed : true,
		menuType : "submenu",
		name : "Video",
		func : enterSubmenu
	},
    
    {
		allowed : true,
		menuType : "submenu",
		name : "Other",
		func : enterSubmenu
	},

	variable_clone(goBack)
]

options[$ "Audio"] = [
    
    {
		allowed : true,
		menuType : "toggle",
		name : "Toggle Mute",
        value : global.settings.sound.mute,
		func : function(){ 
            global.settings.sound.mute = !global.settings.sound.mute; 
            value = global.settings.sound.mute 
        },
        draw : drawToggle
	},
    
	{
		allowed : true,
		menuType : "slider",
		name : "Master Volume",
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
		menuType : "slider",
		name : "Music Volume",
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
		menuType : "slider",
		name : "SFX Volume",
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
		menuType : "slider",
		name : "Voice Volume",
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

options[$ "Video"] = [
    
{
		allowed : true,
		menuType : "toggle",
		name : "Fullscreen",
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
		menuType : "slider",
		name : "Int Scale",
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
		menuType : "slider",
		name : "Camera Spd",
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

options[$ "Other"] = [
    
    {
		allowed : true,
		menuType : "slider",
		name : "Text Speed",
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
		menuType : "toggle",
		name : "Input Display",
        value : SETTINGS.other.inputDisplay,
		func : function(){ 
            
            SETTINGS.other.inputDisplay = !SETTINGS.other.inputDisplay; 
            value = SETTINGS.other.inputDisplay
        },
        draw : drawToggle
	},
    
    {
		allowed : true,
		menuType : "toggle",
		name : "Dash Alert",
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
        menuType : "submenu",
        name : "Toggle Debug",
        func : function(){ global.debug = !global.debug }
    }
)

if DEV array_insert(options[$ "Settings"], 0,
    {
		allowed : true,
		menuType : "toggle",
		name : "DEV ADVANTAGE",
        value : SETTINGS.other.devAdv,
		func : function(){ 
            
            SETTINGS.other.devAdv = !SETTINGS.other.devAdv; 
            value = SETTINGS.other.devAdv
        },
        draw : drawToggle
	},
)

menuControls()