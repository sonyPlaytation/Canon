#macro TEXT			new textAction
#macro SPEAKER		new speakerAction
#macro PARTYSPEAK	new speakersAddParty
#macro CHOICE		new choiceAction
#macro OPTION		new optionAction
#macro GOTO			new gotoAction
#macro CHECKFLAG	new checkFlagAction
#macro CHECKITEM	new checkItemAction
#macro NEXT			new nextAction
#macro SET			new setFlagAction
#macro HOLD			new holdAction
#macro PLAY			new playAction
#macro GIVE			new giveItemAction
#macro BEGINSAVE	new saveAction
#macro CALL			new callAction
#macro AFTERTEXT	with (oTextBox) postDialogue = function()

function initDialogue(){
    
    initDialogueAct1()
    initFlavorTextAct1()
}

#region Custom Scribble Events

    function scribRumble() { global.cam.shake_screen(20,10); SFX snHit7 }
    scribble_typists_add_event("rumble", scribRumble);

    //TODO fix inline portrait change method
    function scribPortraitChange(_element, _params, _index) 
    { 
        if array_length(_params) < 2 {_params[1] = 0}
        oTextBox.sprite = asset_get_index(string_trim(_params[0])); 
        oTextBox.emotion = real(string_trim(_params[1])); 
    }
    scribble_typists_add_event("portrait", scribPortraitChange);

#endregion

function dialogueAction() constructor {

    act = function() { };
}

///@param{string} Message
///@param{Enum.TXTPOS} textPosition
function shortMessage(_text,yMode = TXTPOS.BTM)
{
    global.topics[$ "shortMessage"] = 
    [ 
        TEXT($"{_text}")
    ]

    startDialogue("shortMessage",yMode);
}

function sysMessage(_text)
{
    global.topics[$ "sysMessage"] = 
    [ 
        TEXT($"{_text}")
    ]

    startDialogue("sysMessage",);
}

function textAction(_text) : dialogueAction() constructor
{
    text = _text;
        
    act = function(textbox)
    {
        textbox.setText(text);
        textbox.onHold = false;	
    }
}

function saveAction() : dialogueAction() constructor
{		
    act = function(textbox)
    {
        textbox.next();
        beginSave();
    }
}


function holdAction() : dialogueAction() constructor
{
    if instance_exists(oCutscene)
    {
        with oCutscene {layer_sequence_play(thisScene)}	
    }

    act = function(textbox)
    {
        textbox.onHold = true;	
    }
}

function playAction() : dialogueAction() constructor
{
    if instance_exists(oCutscene)
    {
        with oCutscene {layer_sequence_pause(thisScene)}	
    }

    act = function(textbox)
    {
        textbox.next();
        textbox.onHold = false;	
    }
}

function callAction(_func = function(){}, _afterText): dialogueAction() constructor {
	
	global.dialoguefunc = _func;
	after = _afterText;
	
	act = function(textbox)
    {
        if after {AFTERTEXT{global.dialoguefunc()}} else global.dialoguefunc();
		textbox.next();
    }
}


function endHold()
{
    if instance_exists(oTextBox) { oTextBox.next(); oTextBox.onHold = false }
    if instance_exists(oCutscene){ with oCutscene {layer_sequence_pause(thisScene)}	}
}

function textSoundLUT(_name)
{
    switch (_name)
    {
        case "":					return [snNarr];
        case FLAGS.playerName:		return [snTextNils1,snTextNils2,snTextNils3,snTextNils4,snTextNils5];
        case FLAGS.ladName:			return [snTextChar1,snTextChar2,snTextChar3,snTextChar4,snTextChar5];
        case FLAGS.stinkName:       return [snTextMatt1,snTextMatt2,snTextMatt3,snTextMatt4,snTextMatt5];
        case FLAGS.knightName:		return [snTextGwen1,snTextGwen2,snTextGwen3,snTextGwen4,snTextGwen5];
    }
}

function speakerAction(_name = "", _sprite = noone, _frame = 0, _side = PORT_SIDE.L, _sound = textSoundLUT(_name)) : dialogueAction() constructor
{
    name = _name;
    sprite = _sprite;
    side = _side;
    sound = _sound;
    frame = _frame;
        
    act = function(textbox)
    {
        textbox.activeSpeaker = side;
        textbox.speakersVisible = true;
    
        entry = {}
        if name != ""
        {
            entry[$ name] = 
            {
                sprite : sprite,
                emotion : frame,
                alpha : 0,
                y : TILE_SIZE
            }
    
            if sprite != noone
            {	
                if !array_contains(textbox.speaker[side],entry[$ name])
                {
                    textbox.speaker[side] = array_filter(textbox.speaker[side],function(element,index)
                    {
                        return element.sprite != sprite;
                    })
                    textbox.portSlide[side] = 1;
                }
                else
                {
                    var pos = array_get_index(textbox.speaker[side],entry[$ name])
                    textbox.speaker[side][pos].emotion = frame
                    textbox.portSlide[side] = 0;
                }
        
                array_insert(textbox.speaker[side],0,entry[$ name]);
        
            }
        } else textbox.activeSpeaker = -1;
    
        textbox.name = name;
        textbox.sound = sound;
    
        textbox.next();
    }
}

function speakersAddParty( _side = PORT_SIDE.L ) : dialogueAction() constructor
{
    name = "Nils"
    side = _side;
    sound = textSoundLUT(name);
    ports = 
    [
        sPortNils,
        sPortChar,
        sPortMatt
    ]
        
    act = function(textbox)
    {
        textbox.activeSpeaker = side;
        textbox.speakersVisible = true;
    
        entry = {}

        for (var i = array_length(PARTY)-1; i >= 0 ; i--) {
            
            var _name = PARTY[i].name
            entry[$ _name] = 
            {
                sprite : ports[i],
                emotion : 0,
                alpha : 0,
                y : TILE_SIZE
            }
            
            array_insert(textbox.speaker[side],0,entry[$ _name]);
        }

        textbox.name = name;
        textbox.sound = sound;
    
        textbox.next();
    }
}

function choiceAction(_text) : dialogueAction() constructor
{
    text = _text;

    options = [];
    for (var i = 1; i < argument_count; i++)
    { array_push(options, argument[i]); }

    act = function(textbox)
    {
        textbox.setText(text);
        textbox.options = options;
        textbox.optCount = array_length(options);
        textbox.currentOption = 0;
    }
}

function optionAction(_text, _topic) : dialogueAction() constructor
{
    text = _text;
    topic = _topic;

    act = function(textbox)
    {
        textbox.setTopic(topic);
        show_debug_message($"Set topic: {topic}");
    }
}

function gotoAction(_topic) : dialogueAction() constructor
{
    topic = _topic;

    act = function(textbox)
    {
        textbox.setTopic(topic);	
        show_debug_message($"Set topic: {topic}");
    }
}

function checkFlagAction(_source, _flag, _operator, _check, _ifTrue, _ifFalse = -1) : dialogueAction() constructor
{
    source = _source
    flag = _flag;
    operator = _operator;
    check = _check;
    ifTrue = _ifTrue;
    ifFalse = _ifFalse;
    isTrue = false

    act = function(textbox)
    {
        switch(operator)
        {
            case ">":	isTrue = (source[$ flag] >  check) break;
            case "<":	isTrue = (source[$ flag] <  check) break;		   
            case ">=":	isTrue = (source[$ flag] >= check) break;			   
            case "<=":	isTrue = (source[$ flag] >= check) break;			   
            case "==":	isTrue = (source[$ flag] == check) break;			   
            case "!=":	isTrue = (source[$ flag] != check) break;
        }

        if isTrue {textbox.setTopic(ifTrue);} 
        else if ifFalse = -1 {textbox.next();}
        else {textbox.setTopic(ifFalse)}
    }
}

///@param {real} item The item to check for, as a struct reference.
///@param {string} ifTrue Topic to jump to if check resolves true.
///@param {string} ifFalse Topic to jump to if check resolves false.
///@param {bool} has Check for if player should have the item or not.
///@param {bool} remove If found, whether or not to remove item from player's inventory.
function checkItemAction(_item, _ifTrue, _ifFalse = -1, _has = true, _remove = false) : dialogueAction() constructor {
    
    item = _item
    has = _has;
    remove = _remove;

    ifTrue = _ifTrue;
    ifFalse = _ifFalse;

    act = function(textbox)
    {
        if has {isTrue = array_contains(global.inv[item.type],item)} else isTrue = !array_contains(global.inv[item.type],item)

        if isTrue {textbox.setTopic(ifTrue);} 
        else if ifFalse = -1 {textbox.next();}
        else {textbox.setTopic(ifFalse)}
    }
}

/// @param {struct} source The struct to change.
/// @param {string} flag The key's name as a string.
/// @param {real} value The value to set.
/// @desc Set a flag in any struct from within dialogue.
function setFlagAction(_source, _flag, _value) : dialogueAction() constructor {
    
    source = _source
    flag = _flag;
    value = _value; 

    act = function(textbox)
    {
        source[$ flag] = value
        show_debug_message($"Set '{flag}' to {value} via Dialogue")
        textbox.next();
    }
}

function nextAction() : dialogueAction() constructor
{
    act = function(textbox)
    {
        textbox.next();
    }
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
