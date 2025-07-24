#macro TEXT		new textAction
#macro SPEAKER	new speakerAction
#macro CHOICE	new choiceAction
#macro OPTION	new optionAction
#macro GOTO		new gotoAction
#macro CHECK	new checkFlagAction
#macro NEXT		new nextAction
#macro SET		new setFlagAction

function dialogueAction() constructor {

	act = function() { };
}

function textAction(_text) : dialogueAction() constructor
{
	text = _text;
			
	act = function(textbox)
	{
		textbox.setText(text);
	}
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

function checkFlagAction(_flag, _operator, _check, _ifTrue, _ifFalse = -1) : dialogueAction() constructor
{
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
			case ">":	isTrue = struct_get(FLAGS,flag) >  check break;
			case "<":	isTrue = struct_get(FLAGS,flag) <  check break;		   
			case ">=":	isTrue = struct_get(FLAGS,flag) >= check break;			   
			case "<=":	isTrue = struct_get(FLAGS,flag) >= check break;			   
			case "==":	isTrue = struct_get(FLAGS,flag) == check break;			   
			case "!=":	isTrue = struct_get(FLAGS,flag) != check break;
		}
	
		if isTrue {textbox.setTopic(ifTrue);} 
		else if ifFalse = -1 {textbox.next();}
		else {textbox.setTopic(ifFalse)}
	}
}

function setFlagAction(_flag, _set) : dialogueAction() constructor
{
	flag = string(_flag);
	set = _set; 
	
	act = function(textbox)
	{
		struct_set(global.flags, flag, set)
		show_debug_message($"Set global flag '{flag}' to {set} via Dialogue")
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

function startDialogue(topic)
{
	if instance_exists(oTextBox){return};
	
	var inst = instance_create_depth(x,y,-999,oTextBox);
	inst.setTopic(topic);
	show_debug_message($"Set topic: {topic}");
}

