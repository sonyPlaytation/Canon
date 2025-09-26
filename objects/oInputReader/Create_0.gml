/// @

inputs = [];
inputsActionable = ""
inputsMax = 20;
inputsString = ""
inputsHeldTimer = 0;
dirSprite = "[sInputArrows, 8]"
dir = 5;
numPadDir = -1;
prevDir = 0;

linesMax = 6;
lineHeight = 16
drawX = 96;
drawY = 12;
alpha = 0;
alphaTarg = 1;
currKey = "";

comboResetTime = 16;

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

strengths =
[
	"Light",
	"Medium",
	"Heavy",
	"EX"
]

moves =
{
	superart1 : ["236236L", "236L236L"],
	superart2 : ["236236M", "236M236M"],
	superart3 : ["236236H", "236H236H"],
	
	fireball : ["236L","236M","236H"],
	
}

anyInput = array_concat(inputsToCheck,directionsToCheck);

detectInputs = function()
{

	if InputCheckMany(anyInput)
	{
		
		alarm[0] = comboResetTime // five frames after inputs stop coming in, wipe the inputs
		
		numPadDir = 5;
		var frameInput = [];
		
		if InputCheckMany(directionsToCheck)
		{ 
			dir = (InputDirection(dir,INPUT_CLUSTER.NAVIGATION) div 45); 
		} else dir = -1

		switch (dir)
		{
			case 0: numPadDir = 6 break;
			case 1: numPadDir = 9 break;
			case 2: numPadDir = 8 break;
			case 3: numPadDir = 7 break;
			case 4: numPadDir = 4 break;
			case 5: numPadDir = 1 break;
			case 6: numPadDir = 2 break;
			case 7: numPadDir = 3 break;
			case 8: numPadDir = 6 break;
		}
		
		if numPadDir != prevDir
		
		if numPadDir != 5 {inputsActionable += string(numPadDir);}
		
		if InputPressedMany(inputsToCheck)
		{
			for (var i = 0; i < array_length(inputsToCheck); i ++)
			{
				var thisInput = InputVerbGetExportName(inputsToCheck[i]);
				if InputPressed(inputsToCheck[i]) 
				{
					inputsActionable += thisInput
					checkMoves(inputsActionable) 
					//if inputsActionable != "" 
					//{
					//	show_debug_message(inputsActionable + thisInput)
					//}
				}	
			}
		}
		//array_insert(inputsActionable,0,frameInput);
	} 
	else numPadDir = 5;
	
	//if inputsActionable != "" {show_debug_message(inputsActionable)}
	
	prevDir = numPadDir;
}

checkMoves = function(_inputString)
{
	inputString = _inputString
	struct_foreach(moves,function(key,value)
	{
		currKey = key;
		if !is_array(value) {value = [value]};
	
		array_foreach(value,function(element,index)
		{
			if string_pos(element,inputString) != 0
			{
				
				//show_debug_message(inputString);
				show_debug_message($"MOVE REGISTERED: {strengths[index]} {other.currKey}!");
			
				// TODO: Have the motion inputs be sent to oBattle 
			
				inputString = "";
			}
		})
	});	
}
