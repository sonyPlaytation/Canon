#macro TEXT		new textAction
#macro SPEAKER	new speakerAction
#macro CHOICE	new choiceAction
#macro OPTION	new optionAction
#macro GOTO		new gotoAction

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

function speakerAction(_name, _sprite = noone, _side = undefined) : dialogueAction() constructor
{
	name = _name;
	sprite = _sprite;
	side = _side;
			
	act = function(textbox)
	{
		textbox.name = name;
		textbox.sprite = sprite;
		
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
	}
}

function gotoAction(_topic) : dialogueAction() constructor
{
	topic = _topic;
	
	act = function(textbox)
	{
		textbox.setTopic(topic);	
	}
}

function startDialogue(topic)
{
	if instance_exists(oTextBox){return};
	
	var inst = instance_create_depth(x,y,-999,oTextBox);
	inst.setTopic(topic);
}

