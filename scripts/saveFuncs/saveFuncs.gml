


function initFlags(){
    
    global.flags = {
        playerName :    DEV ? "Nils" : "???",
        ladName :       DEV ? "Charlie" : "Child",
        stinkName :     DEV ? "Matthew" : "Patron",
        knightName :    DEV ? "Gwen" : "Black Knight",
        
        cutscenes :[],
        enemiesActive : DEV,
        canDash : true,
        
        // act flags in rough chronological order
        act1 : {
            solitaire: 0,
            officeBathroomKey : false,
            narratorFunny : false,
            lostAsFuck : 0,
            hasDevilsGun : false,
            chargeTackle : false,
        },
    }
}

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

	if FLAGS.act1.hasDevilsGun {flashScreen(c_red,snDoomSave,0.05)};
	
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
		],
		party : [],
        equips : [],
	}
	
	for (var i = 0; i < array_length(global.inv); i++) {
		for (var j = 0; j < array_length(global.inv[i]); j++) {
			
            array_push( mainStruct.inv[i], global.inv[i][j])
		}
	}
	
	for (var i = 0; i < array_length(PARTY); ++i) {
		
        for (var j = 0; j < array_length(PARTY[i].equips); j++) {
        	mainStruct.equips[i][j] = PARTY[i].equips[j].equip;
        }
		
		mainStruct.stats[i] = PARTY[i].stats;
        mainStruct.party[i] = PARTY[i].name
	}
	
	var _json = json_stringify(mainStruct, DEV);
	SaveString(_json, SAVEFILE,true);
}

function SaveString( _str, _filename, _message = false)
{
	var _buffer = buffer_create(string_byte_length(_str)+1,buffer_fixed,1);
	buffer_write(_buffer, buffer_string, _str);
	buffer_save(_buffer, _filename);
	show_debug_message("Successfully wrote file: "+_filename);
	buffer_delete(_buffer);
    
	if _message startDialogue("gameSaved",TXTPOS.MID)
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
	
	for (var i = 0; i < array_length(mainStruct.party); ++i) {
        
	    PARTY[i] = global.characters[$ mainStruct.party[i]];
        
        for (var j = 0; j < array_length(mainStruct.equips[i]); j++) {
        	
            var item = mainStruct.equips[i][j];
            PARTY[i].equips[j].equip = item;
            
        	if item != -4 global.items[$ item].equipped = PARTY[i].name;
        }
        
        PARTY[i].stats = mainStruct.stats[i];
	}
	
	FLAGS = mainStruct.flags;
	
	for (var i = 0; i < array_length(mainStruct.inv); i++)
	{
		global.inv[i] = []
		for (var j = 0; j < array_length(mainStruct.inv[i]); j++)
		{
			array_push(global.inv[i], mainStruct.inv[i][j] )
		}
	}
	
	if roomChange { transition(mainStruct.room,sqFadeOut,sqFadeIn,,,,,true) }
	
}

function saveSettings()
{
    show_debug_message("Saved Settings!");
	var _string = json_stringify(SETTINGS, true);
	SaveString(_string,"Canon.ini");
}

function loadSettings()
{
	var file = "Canon.ini"
	if !file_exists(file) return;
	
	try{
		
		show_debug_message("Loaded Settings!");
		var _json = LoadString(file);
		var mainStruct = json_parse(_json);
		
		// if i have added new settings since the last boot, merge the two to avoid a crash
		if !array_equals(struct_get_names(mainStruct),struct_get_names(SETTINGS)) {
			
			var newSettings = variable_clone(SETTINGS)
			array_foreach(struct_get_names(mainStruct),function(element,index){
				
				if struct_exists(SETTINGS,element){
					SETTINGS[$ element] = mainStruct[$ element];
				};
			})
			
			exit;
		} else SETTINGS = variable_clone(mainStruct);
		
	} catch(ex){
		file_delete(file)
	}
    
}


function deleteSave(){
	
	file_delete(SAVEFILE); 
	initFlags();
}