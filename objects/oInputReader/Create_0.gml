/// @

inputs = [];
inputsString = ""
inputsHeldTimer = 0;
dirSprite = "[sInputArrows, 8]"
dir = 9;

linesMax = 6;
lineHeight = 16
drawX = 96;
drawY = 12;
alpha = 0;
alphaTarg = 1;

scribble_font_bake_outline_8dir("fSmart", "fSmartOut",c_black,false);

inputsToCheck = 
[
	INPUT_VERB.GRUDGE,
	INPUT_VERB.BL,
	INPUT_VERB.BM,
	INPUT_VERB.BH
]

inputSprites = 
[
	sInputG,
	sInputL,
	sInputM,
	sInputH
]

directionsToCheck = 
[
	INPUT_VERB.UP,
	INPUT_VERB.DOWN,
	INPUT_VERB.LEFT,
	INPUT_VERB.RIGHT
]