#macro TEXT			new textAction
#macro SPEAKER		new speakerAction
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
#macro AFTERTEXT	with (oTextBox) postDialogue = function()

#region Custom Scribble Events

	function scribRumble() { global.cam.shake_screen(20,10); SFX snHit7 }
	scribble_typists_add_event("rumble", scribRumble);
	
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

function saveAction(_text) : dialogueAction() constructor
{		
	text = _text
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

function endHold()
{
	if instance_exists(oTextBox) { oTextBox.next(); oTextBox.onHold = false }
	if instance_exists(oCutscene){ with oCutscene {layer_sequence_pause(thisScene)}	}
}

function textSoundLUT(_name)
{
	switch (_name)
	{
		case "":			return [sNarr];
		case "Nils":		return [snTextNils1,snTextNils2,snTextNils3,snTextNils4,snTextNils5];
		case "Gwen":		return [snTextGwen1,snTextGwen2,snTextGwen3,snTextGwen4,snTextGwen5];
	}
}

function speakerAction(_name = "", _sprite = noone, _frame = 0, _side = undefined, _sound = textSoundLUT(_name)) : dialogueAction() constructor
{
	name = _name;
	sprite = _sprite;
	side = _side;
	sound = _sound;
	frame = _frame;
			
	act = function(textbox)
	{
		textbox.name = name;
		textbox.sprite = sprite;
		textbox.sound = sound;
		textbox.emotion = frame;
		
		if !is_undefined(side)
		{ textbox.portSide = side; }
		
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

function checkItemAction(_item, _ifTrue, _ifFalse = -1, _inv = ITEM_TYPE.KEY,_has = true, _remove = false) : dialogueAction() constructor
{
	item = _item
	inv = _inv;
	has = _has;
	remove = _remove;
	
	ifTrue = _ifTrue;
	ifFalse = _ifFalse;
	
	act = function(textbox)
	{
		if has {isTrue = array_contains(global.inv[inv],item)} else isTrue = !array_contains(global.inv[inv],item)
	
		if isTrue {textbox.setTopic(ifTrue);} 
		else if ifFalse = -1 {textbox.next();}
		else {textbox.setTopic(ifFalse)}
	}
}

function setFlagAction(_source, _flag, _set) : dialogueAction() constructor
{
	source = _source
	flag = string(_flag);
	set = _set; 
	
	act = function(textbox)
	{
		source[$ flag] = set
		show_debug_message($"Set '{flag}' to {set} via Dialogue")
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
	if instance_exists(oTextBox){return};	
	
	if oPlayer.y > (global.cam.y + (TILE_SIZE/2))
	{
		yMode = TXTPOS.TOP
	}
	
	var inst = instance_create_depth(x,y,-999,oTextBox);
	inst.yMode = yMode
	inst.setTopic(topic);
	show_debug_message($"Set topic: {topic}");
}

