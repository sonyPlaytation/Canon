/// @

#macro DIALOGUE "DIALOGUE MASTER.yarn"

oInputReader.alphaTarg = 0;
depth = -9999
global.letterbox = true;

// CHATTERBOX

global.chatter = ChatterboxCreate("text");

ChatterboxVariableSet("Nils", FLAGS.playerName)
ChatterboxVariableSet("Gwen", FLAGS.knightName)
ChatterboxVariableSet("Matthew", FLAGS.stinkName)
ChatterboxVariableSet("Charlie", FLAGS.ladName)
ChatterboxVariableSet("shortMsg", global.shortMsg)
ChatterboxVariableSet("saveMessage", global.saveMessage)

entry = {}

onHold = false;

alpha = 0;
alphaTarg = 1;
alphaSpeed = 0.2

// General
margin = TILE_SIZE*1.5;
padding = 16
width = display_get_gui_width() - (margin*4);
height = TILE_SIZE*4;
doSquish = 0;
squishEvery = 10 - (10*SETTINGS.other.textspeed)

enum TXTPOS {
	
	TOP,
	MID,
	BTM
}

x = (display_get_gui_width() - width) /2;
y = display_get_gui_height() - height - padding; 

drawNow = false;

with pProtag {
	
	going = false;
	image_speed = 0
}

font = fSmall;
color = c_white;
spd = SETTINGS.other.textspeed;
txtX = padding;
txtY = padding/2;
txtW = width - (padding * 2);
draw_set_font(font);

// Portrait 
portraitX[PORT_SIDE.L] = x;
portraitX[PORT_SIDE.R] = x + width;
portSlide[PORT_SIDE.L] = 0;
portSlide[PORT_SIDE.R] = 0;
portraitY = y + (TILE_SIZE/2);
speakersVisible = true;

// Speaker
nameFont = fQuit;
nameColor = c_white;
sound = [snNarr];
activeSpeaker = noone;
speakerSquish = 1;

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

if instance_exists(oPlayer) oPlayer.hasControl = false
	
// CHATTERBOX
//chat = ChatterboxCreate("test");

enum PORT_SIDE {
	L,
	R
}

textAll = {
	speaker : "",
	data : "",
	speech : ""
}

speaker[PORT_SIDE.L] = [];
speaker[PORT_SIDE.R] = [];
//portW = sprite_get_width(sprite); // For a portrait background 
//portH = sprite_get_height(sprite);
//portSide = PORT_SIDE.L;
name = ""; 
nameW = 0;
charWrap = false;
forceSpd = 30;

options = [];
currentOption = 0;
optCount = 0;
optSpacing = txtW/optCount;

dialogueResponse = -1
postDialogue = function(){}

// Methods
setTopic = function(topic) {
    
	ChatterboxJump(global.chatter,topic);
	next(true);
};

next = function(progress = false) {
	
	if !progress ChatterboxContinue(global.chatter);
    if !ChatterboxIsStopped(global.chatter) typist.reset();
            
	text = ChatterboxGetContentSpeech(global.chatter,0)
	getTextAttributes();
	addTypingQuirks(textAll);
	
	if ChatterboxIsStopped(global.chatter) /*and typist.get_state() >= 1 */{ instance_destroy() }
	else setText(textAll.speech) 
};

setText = function(newText)
{
	sound = textSoundLUT(name);
	text = newText;

    typist
        .in(min(spd,forceSpd),0)
        .character_delay_add(". ", 250)
        .character_delay_add("! ", 250)
        .character_delay_add("? ", 250)
        .character_delay_add(", ", 125)
        .character_delay_add("\n", 400)
        .sound(sound,0.1,0.9,1.1,global.voiceVol);
	
	scribb = scribble(text)
		.wrap(txtW,,charWrap)
		.starting_format(font_get_name(font),color)
		.fit_to_box(txtW,height-8,charWrap);
		
	myName = scribble(name)
		.starting_format(font_get_name(font),nameColor)
		.align(fa_left,fa_middle)
		
	length = string_length_scribble(newText);
	progress = 0;
}

getTextAttributes = function(){
	
	textAll = {
		speaker : 	ChatterboxGetContentSpeaker(global.chatter,0),
		tags : 		ChatterboxGetContentSpeakerData(global.chatter,0),
		speech : 	ChatterboxGetContentSpeech(global.chatter,0)
	}
	
	//if textAll.speaker == "" or textAll.speaker == "Gaia" 
	//{ textAll.speech = string_insert("// ",textAll.speech,1) }
	
	parseChatterbox(textAll)
	
	typist.sound(sound,0.1,0.9,1.1,1);
	
	scribb = scribble(text)
		.wrap(txtW,,charWrap)
		.starting_format(font_get_name(font),color)
		.fit_to_box(txtW,height-8);
    
		
	myName = scribble(name)
		.starting_format(font_get_name(font),nameColor)
		.align(fa_left,fa_middle)
		
	currentOption = 0;
	length = string_length_scribble(textAll.speech);
	progress = 0;
}