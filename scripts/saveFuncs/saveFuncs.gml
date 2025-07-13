// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function saveGame()
{
	var mainStruct = {
		ver : global.ver,
		lvlFloor : global.lvlFloor,
		lvlAct : global.lvlAct,
		seed : oGame.seed,
		room : room,
		warp : oNewt.lastWarp,
		weap : {
			weapons : [],
			ammo : [],
		},
		inv : {
			level : oInv.levelCurrent,
			souls : oInv.souls,
			sodas : oInv.sodas,	
			lives : lives,
			hpMax : oInv.hpMax,
			hp : oInv.hp,
			money : oInv.money,
			pocket : oPocket.slot,
			pState : oPocket.state,
			onHit : oInv.onHit
		},
		passives : []
	}
	
	array_copy(mainStruct.weap.weapons,0,oWeapon.heldweapons,0,array_length(oWeapon.heldweapons));
	array_copy(mainStruct.weap.ammo,0,oWeapon.ammo,0,array_length(oWeapon.ammo));
	
	for (var i = 0; i < ds_list_size(oInv.myItems); i++)
	{
		var passive = ds_list_find_value(oInv.myItems,i);
		mainStruct.passives[i] = passive;
	}
	
	var _json = json_stringify(mainStruct, true);
	SaveString(_json, "NEWTsav");
}

function SaveString( _str, _filename)
{
	var _buffer = buffer_create(string_byte_length(_str)+1,buffer_fixed,1);
	buffer_write(_buffer, buffer_string, _str);
	buffer_save(_buffer, _filename);
	show_debug_message("Successfully wrote file: "+_filename);
	buffer_delete(_buffer);
}

function LoadString(_filename)
{
	try
	{
		var _buffer = buffer_load(_filename);
		var _string = buffer_read(_buffer, buffer_string);
		
		buffer_delete(_buffer);
		show_debug_message("Successfully read file: "+_filename);
		return _string;
		
	}
	catch(fileWeird)
	{
		file_delete("NEWTsav");
		room_goto(rLobby);
	}
}

function loadGame(){

	if !file_exists("NEWTsav") return;
	
	try
	{
		var _json = LoadString("NEWTsav");
		var mainStruct = json_parse(_json);
	
		global.lvlAct = mainStruct.lvlAct;
		global.lvlFloor = mainStruct.lvlFloor;
		oGame.seed = mainStruct.seed;
	
		var target = mainStruct.room;
	
		instance_destroy(oWeapon);
		instance_create_depth(0,0,0,oUnlocks);
		instance_create_depth(0,0,0,oWeapon);
	
		instance_destroy(pAlly);
		instance_destroy(oInv);
		instance_create_depth(0,0,0,oInv);
	
		oInv.levelCurrent	=	mainStruct.inv.level;
		oInv.souls			=	mainStruct.inv.souls;
		oInv.sodas			=	mainStruct.inv.sodas;	
		lives				=	mainStruct.inv.lives;
		oInv.hpMax			=	mainStruct.inv.hpMax;
		oInv.hp				=	mainStruct.inv.hp;
		oInv.money			=	mainStruct.inv.money;
		oInv.onHit			=	mainStruct.inv.onHit;
		oPocket.slot		=	mainStruct.inv.pocket;
		oPocket.state		=	mainStruct.inv.pState;
	
	
		for (var i = 0; i < array_length(mainStruct.passives); i++)
		{
			var pass = mainStruct.passives[i]
			addPassive(pass);
		};
	
		oWeapon.heldweapons = mainStruct.weap.weapons;
		oAmmoCount.weap = mainStruct.weap.weapons;
		oWeapon.ammo = mainStruct.weap.ammo;
		oWeapon.sprite_index = oWeapon.sprite;

		slideTransition(TRANS_MODE.INIT,target);
	}
	catch(failedLoad) // your mom 
	{
		
		oCamera.badNews = true;
		//oCamera.ThreeDee = true;
		file_delete("NEWTsav");
		room_goto(rTennis);
	}
	
	
}

function saveSettings()
{
	var settingsStruct = 
	{
		settings : {
			mute : global.mute,
			masterVol : global.masterVolume,
			musicVol : global.musicVolume,
			sfxVol : global.sfxVolume,
			scrShake : global.screenShakeMod,
			mouselock : global.mouselock,
			hudOffset : global.hudOffset,
			itemHud : global.itemtracker,
			statHud : global.stattracker,
			pauseFocus : global.pauseFocusLost,
			fullscreen : global.fullscreen
		},

		padCont : InputBindingsExport(true),
		kbmCont : InputBindingsExport(false)
	};
	
	var _string = json_stringify(settingsStruct, true);
	SaveString(_string,"NEWTsett");
}

function loadSettings()
{
	if !file_exists("NEWTsett") return;
	
	var _json = LoadString("NEWTsett");
	var mainStruct = json_parse(_json);
	
	global.mute				=	mainStruct.settings.mute	
	global.masterVolume		=	mainStruct.settings.masterVol
	global.musicVolume		=	mainStruct.settings.musicVol
	global.sfxVolume		=	mainStruct.settings.sfxVol	
	global.screenShakeMod	=	mainStruct.settings.scrShake
	global.mouselock		=	mainStruct.settings.mouselock
	global.hudOffset		=	mainStruct.settings.hudOffset
	global.itemtracker		=   mainStruct.settings.itemHud	
	global.stattracker		=   mainStruct.settings.statHud	
	global.pauseFocusLost	=	mainStruct.settings.pauseFocus
	
	InputBindingsImport(true, mainStruct.padCont);
	InputBindingsImport(false, mainStruct.kbmCont);
	
	if mainStruct.settings.fullscreen {toggleFullscreen();}
}