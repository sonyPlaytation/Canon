/// @


/*

if pressing any input, figure out what buttons are being pressed 
and then associate that as one group of "current input"

then check if these are the same inputs as last frame

if yes, then just increment the frame timer,
if no then update the group of current inputs,

if nothing is pressed then its registered as holding neutral

*/
if !global.pauseEvery 
{

	var prevInputs = inputsString;
	var prevDir = dir;

	inputsString = "[sInputG,0][sInputL,0][sInputM,0][sInputH,0]";

	if InputCheckMany(directionsToCheck)
	{ dir = InputDirection(dir,INPUT_CLUSTER.NAVIGATION) div 45; } else dir = 8;

	dirSprite = string($"[sInputArrows, {dir}]");

	if InputCheckMany(inputsToCheck)
	{
		inputsString = ""
		for (var i = 0; i < array_length(inputsToCheck); i ++)
		{
			var thisInput = InputCheck(inputsToCheck[i]);
			inputsString += string($"[" + sprite_get_name(inputSprites[i]) + $", {thisInput}]");
		}
	} 

	var currInputs = inputsString;
	var currDir = dir;
	var finalInputsString = $"{dirSprite} {inputsString}"

	if (prevInputs != currInputs) or (prevDir != currDir) // if inputs are not the same as last frame
	{
		array_insert(inputs, 0, $"{inputsHeldTimer} {finalInputsString}");
		inputsHeldTimer = 1;
	}
	else
	{
		if inputsHeldTimer < 99 {inputsHeldTimer++};
		inputs[0] = $"{inputsHeldTimer} {finalInputsString}";
	}

	if array_length(inputs) >= linesMax {array_resize(inputs,linesMax);}

}