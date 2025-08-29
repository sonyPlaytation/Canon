

function beginSave()
{
	saveGame()	
}

function saveGame()
{
	var mainStruct = 
	{
		flags : FLAGS,
		party : PARTY,
		inv :
		[
			[],
			[],
			[],
			[],
			[],
		]
	}
	
	for (var i = 0; i < array_length(global.inv); i++)
	{
		for (var j = 0; j < array_length(global.inv[i]); j++)
		{
			array_push( mainStruct.inv[i], global.inv[i][j].key)
		}
	}
	
	var _json = json_stringify(mainStruct, true);
	SaveString(_json, SAVEFILE);
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
	var _buffer = buffer_load(_filename);
	var _string = buffer_read(_buffer, buffer_string);
		
	buffer_delete(_buffer);
	show_debug_message("Successfully read file: "+_filename);
	return _string;
}

function loadGame(){

	if !file_exists(SAVEFILE) return;
	
	var _json = LoadString(SAVEFILE);
	var mainStruct = json_parse(_json);
	
	PARTY = mainStruct.party;
	FLAGS = mainStruct.flags;
	
	for (var i = 0; i < array_length(mainStruct.inv); i++)
	{
		for (var j = 0; j < array_length(mainStruct.inv[i]); j++)
		{
			array_push(global.inv[i], global.items[$ mainStruct.inv[i][j] ])
		}
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