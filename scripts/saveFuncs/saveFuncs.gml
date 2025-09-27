

function beginSave()
{
	audio_pause_all()
	oGame.nowSaving = true;
	global.pauseEvery = true;
	oPlayer.JustHitEnemyButCanStillMoveALittle = 0;
	call_later(45,time_source_units_frames,function()
	{
		audio_resume_all()
		saveGame()	
		global.pauseEvery = false;
	})
}

function saveRoomObjectFlag(_id, _flag, _state = noone)
{
	if !is_string(_flag) and _state == noone
	{
		variable_struct_set(FLAGS, _id ,_flag)
	}
	else
	{
		if !variable_struct_exists(FLAGS, _id) {  FLAGS[$ _id] = {}; }
		variable_struct_set(FLAGS[$ _id],_flag,_state)
	}
	
}

function saveGame()
{
	global.enemiesKilled = {}

	if array_contains(PARTY[0].actions,global.actionLibrary.devilshot) {flashScreen(c_red,sDoomSave,0.05)};
	
	file_delete(SAVEFILE)
	oGame.nowSaving = true;
	var mainStruct = 
	{
		room : room,
		flags : FLAGS,
		stats : [],
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
	
	for (var i = 0; i < array_length(PARTY); ++i) 
	{
		mainStruct.stats[i] = PARTY[i].stats
	}
	
	var _json = json_stringify(mainStruct, DEV);
	SaveString(_json, SAVEFILE);
}

function SaveString( _str, _filename)
{
	var _buffer = buffer_create(string_byte_length(_str)+1,buffer_fixed,1);
	buffer_write(_buffer, buffer_string, _str);
	buffer_save(_buffer, _filename);
	show_debug_message("Successfully wrote file: "+_filename);
	buffer_delete(_buffer);
	shortMessage("Game Saved",TXTPOS.MID)
	oGame.nowSaving = false;
}

function LoadString(_filename)
{
	try
	{
		var _buffer = buffer_load(_filename);
		var _string = buffer_read(_buffer, buffer_string);
	}
	catch(fileEpicFail)
	{
		file_delete(SAVEFILE) exit;	
	}
	
	buffer_delete(_buffer);
	show_debug_message("Successfully read file: "+_filename);
	return _string;
}

function loadGame(roomChange = false){

	if !file_exists(SAVEFILE) return;
	
	var _json = LoadString(SAVEFILE);
	var mainStruct = json_parse(_json);
	
	for (var i = 0; i < array_length(PARTY); ++i) {
	    PARTY[i].stats = mainStruct.stats[i];
	}
	
	FLAGS = mainStruct.flags;
	
	for (var i = 0; i < array_length(mainStruct.inv); i++)
	{
		for (var j = 0; j < array_length(mainStruct.inv[i]); j++)
		{
			array_push(global.inv[i], global.items[$ mainStruct.inv[i][j] ])
		}
	}
	
	if roomChange { transition(mainStruct.room,sqFadeOut,sqFadeIn,,,,,true) }
	
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