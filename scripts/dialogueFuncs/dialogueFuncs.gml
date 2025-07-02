#macro TEXT new textAction
#macro SPEAKER new speakerAction

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

function speakerAction(_name, _sprite = undefined, _side = undefined) : dialogueAction() constructor
{
	name = _name;
	sprite = _sprite;
	side = _side;
			
	act = function(textbox)
	{
		textbox.name = name;
		
		if !is_undefined(sprite)
		{ textbox.sprite = sprite; }
		
		if !is_undefined(side)
		{ textbox.portSide = side; }
		
		textbox.next();
	}
}

function startDialogue(topic)
{
	if instance_exists(oTextMain){return};
	
	var inst = instance_create_depth(x,y,-999,oTextMain);
	inst.setTopic(topic);
}

function createTopics()
{
	global.topics = {};

	global.topics[$ "Example"] = 
	[
		
		TEXT("This is a garbage can"),
		TEXT("it is sooooooooooooooooooooooooooooooooooo stinky"),
		TEXT("[wave]smelly as shit"),
		TEXT("[sCharlie]"),
		TEXT("[c_red]ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ")
	];
	
	global.topics[$ "Gwen"] = 
	[
		SPEAKER("Nils", sPortNils),
		TEXT("Hi Gwen"),
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("I hate you so fucking much"),
		TEXT("[wave][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie]"),
	];
}