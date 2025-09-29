/// @

depth = -9999

onHold = false

alpha = 0;
alphaTarg = 1;
alphaSpeed = 0.2

// General
margin = TILE_SIZE*1.5;
padding = 16
width = display_get_gui_width() - (margin*4);
height = TILE_SIZE*4;

enum TXTPOS
{
	TOP,
	MID,
	BTM
}

x = (display_get_gui_width() - width) /2;
y = display_get_gui_height() - height - padding; 

yMode = -1
drawNow = false;

with pProtag
{
	going = false;
	image_speed = 0
}

font = fSmall;
color = c_white;
spd = global.textSpeed;
txtX = padding;
txtY = padding/2;
txtW = width - (padding * 2);
draw_set_font(font);

// Portrait 
portraitX[PORT_SIDE.L] = x;
portraitX[PORT_SIDE.R] = x + width;
portraitY = y + (TILE_SIZE/2);
speakersVisible = true;

// Speaker
nameFont = fQuit;
nameColor = c_white;
sound = [sNarr];
activeSpeaker = noone;

// Options
optX = padding*6;
optY = height*0.66;
optW = 300;
optH = 40;
optTxtX = 10;
optColor = c_white;

// Do Not Touch
actions = [];
currentAction = -1;

text = "";
progress = 0;
length = 0;

typist = scribble_typist();
typist
	.in(spd,0)
	.character_delay_add(". ", 250)
	.character_delay_add("! ", 250)
	.character_delay_add("? ", 250)
	.character_delay_add(", ", 125)
	.character_delay_add("\n", 400)

oPlayer.hasControl = false

enum PORT_SIDE
{
	L,
	R
}

speaker[PORT_SIDE.L] = [];
speaker[PORT_SIDE.R] = [];
//portW = sprite_get_width(sprite); // For a portrait background 
//portH = sprite_get_height(sprite);
//portSide = PORT_SIDE.L;
name = ""; 
nameW = 0;

options = [];
currentOption = 0;
optCount = 0;
optSpacing = txtW/optCount;

dialogueResponse = -1
postDialogue = function()
{
	
}

// Methods
setTopic = function(topic)
{
	actions = global.topics[$ topic];
	currentAction = -1;
	
	next();
};

next = function()
{
	currentAction++;
	if (currentAction >= array_length(actions))
	{ instance_destroy(); }
	else 
	{ actions[currentAction].act(id); }
};

setText = function(newText)
{
	sound = textSoundLUT(name);
	text = newText;

	typist.sound(sound,0.1,0.9,1.1,global.sfxVol);
	
	scribb = scribble(text)
		.wrap(txtW)
		.starting_format(font_get_name(font),color)
		.fit_to_box(txtW,height);
		
	myName = scribble(name)
		.starting_format("nameFontMod",nameColor)
		.align(fa_left,fa_middle)
		
	length = string_length_scribble(newText);
	progress = 0;
}