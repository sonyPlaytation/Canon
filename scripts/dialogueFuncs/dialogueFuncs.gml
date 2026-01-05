#macro AFTERTEXT	with (oTextBox) postDialogue = function()

global.shortMsg = "";
global.saveMessage = "";

#region Custom Scribble Events

    function scribRumble() { global.cam.shake_screen(20,10); SFX snHit7 }
    scribble_typists_add_event("rumble", scribRumble);

#endregion

///@param{string} Message
///@param{Enum.TXTPOS} textPosition
function shortMessage(_text,yMode = TXTPOS.BTM) {
	
    global.shortMsg = _text;
    startDialogue("shortMessage",yMode);
}

function callAction(_func = function(){}, _afterText){
	
	global.dialoguefunc = _func;
	after = _afterText;
}

// i dont know what this does but i will keep it
function endHold() {
	
    if instance_exists(oTextBox) { oTextBox.next(); oTextBox.onHold = false }
    if instance_exists(oCutscene){ with oCutscene {layer_sequence_pause(thisScene)}	}
}

function textSoundLUT(_name) {
	
	switch (_name) {
		
		case FLAGS.playerName:
		case "Nils":
		case "???":
			return [snTextNils1,snTextNils2,snTextNils3,snTextNils4,snTextNils5];
			
		case FLAGS.ladName:				
		case "Kid":				
		case "Charlie":				
			return [snTextChar1,snTextChar2,snTextChar3,snTextChar4,snTextChar5];
			
		case FLAGS.stinkName:				
		case "Stinky Patron":
		case "Matthew":
			return [snTextMatt1,snTextMatt2,snTextMatt3,snTextMatt4,snTextMatt5];
			
		case FLAGS.knightName: 
		case "Black Knight":
		case "Gwen":
			return [snTextGwen1,snTextGwen2,snTextGwen3,snTextGwen4,snTextGwen5];
			
		case "":
		default:
			return [snNarr];
	}
}

function portraitLUT(_name) {
	
	switch (_name) {
		
		case FLAGS.playerName:
		case "Nils":
		case "???":	        
			return sPortNils;
			
		case FLAGS.ladName:				
		case "Child":				
		case "Charlie":					
			return sPortChar;
			
		case FLAGS.stinkName:				
		case "Drunk":
		case "Matthew":			
			return sPortMatt;
			
		case FLAGS.knightName: 
		case "Black Knight":
		case "Gwen":			
			return sPortGwen;
			
		case "": 
		default:					
			return sBlank;
	}
}

function speakersAddParty( _side = PORT_SIDE.L ) {
	
    name = FLAGS.playerName
    side = _side;
    sound = textSoundLUT(name);
    ports = [
		
        sPortNils,
        sPortChar,
        sPortMatt
    ]
        
	activeSpeaker = side;
	speakersVisible = true;

	entry = {}

	for (var i = array_length(PARTY)-1; i >= 0 ; i--) {
		
		var _name = PARTY[i].name
		entry[$ _name] = {
            
			sprite : ports[i],
			frame : 0,
			alpha : 0,
			y : TILE_SIZE
		}
		
		array_insert(speaker[side],0,entry[$ _name]);
	}

	name = name;
	sound = sound;

	//next();
}

function checkFlag(_source, _flag, _operator, _check) {
	
	source = _source
	flag = _flag;
	operator = _operator;
	check = _check;
	isTrue = false
	
	switch(operator) {
		
		case ">":	isTrue = (FLAGS[$ source][$ flag] >  check) break;
		case "<":	isTrue = (FLAGS[$ source][$ flag] <  check) break;		   
		case ">=":	isTrue = (FLAGS[$ source][$ flag] >= check) break;			   
		case "<=":	isTrue = (FLAGS[$ source][$ flag] >= check) break;			   
		case "==":	isTrue = (FLAGS[$ source][$ flag] == check) break;			   
		case "!=":	isTrue = (FLAGS[$ source][$ flag] != check) break;
	}

	return isTrue
}

///@param {real} item The item to check for, as a struct key.
///@param {bool} has Check for if player should have the item or not.
///@param {bool} remove If found, whether or not to remove item from player's inventory.
function checkItem(_item, _has = true, _remove = false){
	
	var _itemObj = global.items[$ _item];
	var _type = _itemObj.itemType;
	item = _item;
	has = _has;
	remove = _remove;

	if has {isTrue = array_contains(global.inv[_type],item)} else isTrue = !array_contains(global.inv[_type],item)

	return isTrue
	
}

function setFlag(_category, _value){
	
	FLAGS[$ _category] = _value;
}


function startDialogue(topic,yMode = TXTPOS.BTM)
{
    if instance_exists(oTextBox) and !instance_exists(oPauseMenu) {return};	

    var inst = instance_create_depth(0,0,-999,oTextBox,{
        yMode
    });

    inst.setTopic(topic);
    show_debug_message($"Set topic: {topic}");
}

// CHATTERBOX
//ChatterboxLoadFromFile("test.yarn", "test");
//ChatterboxAddFunction("TEXT", textAction)
//ChatterboxAddFunction("SPEAKER", speakerAction)
//ChatterboxVariableSet("playerName", FLAGS.playerName)


function parseChatterbox(_data){
	
	var tags = string_split(_data.tags,",")

	name = _data.speaker;
	sprite 	= portraitLUT(name);
	side 	= PORT_SIDE.L;
	sound 	= textSoundLUT(name);
	frame = 0;
	
	for (var i = 0; i < array_length(tags); i++) {
		
		if string_starts_with(string_lower(tags[i]),"frame=") { frame = real(string_replace(tags[i],"frame=","")) }
		if string_starts_with(string_lower(tags[i]),"sprite=") { sprite = asset_get_index(string_replace(tags[i],"sprite=","")) }
		if string_starts_with(string_lower(tags[i]),"side=") { side = string_replace(tags[i],"side=","") }
		if string_starts_with(string_lower(tags[i]),"sound=") { sound = asset_get_index(string_replace(tags[i],"sound=","")) }
	}
	
	switch(string_upper(side)){
		
		case "L": side = PORT_SIDE.L; break;
		case "R": side = PORT_SIDE.R; break;
	}
		
	activeSpeaker = side;
	speakersVisible = true;

	if name != "" {
		
        var exists = variable_struct_exists(entry,name)
        
		if sprite != noone {
				
            if !exists { 
                
                entry[$ name] = {
			
                   sprite,
                   frame,
                   alpha : 0,
                   y : TILE_SIZE
               }
                
                array_insert(speaker[side],0,entry[$ name]); 
                portSlide[side] = 1;
            } else {
                
                // array already populated, replacing speaker
                if (array_length(speaker[side]) > 0 and speaker[side][0][$ "name"] != name)  {
                    
                    var pos = array_get_index(speaker[side],entry[$ name])
                    if pos != 0 portSlide[side] = 1;
                    var guy = array_get(speaker[side], pos)
                    array_delete(speaker[side],array_get_index(speaker[side],entry[$ name]),1)
                    array_insert(speaker[side],0,guy); 
                    guy.frame = frame
                    
                    speaker[side][0].y = 0
                } 
            }
		}
	} else activeSpeaker = -1; // no active speakers during system messages

}