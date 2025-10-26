/// @


/*

if pressing any input, figure out what buttons are being pressed 
and then associate that as one group of "current input"

then check if these are the same inputs as last frame

if yes, then just increment the frame timer,
if no then update the group of current inputs,

if nothing is pressed then its registered as holding neutral

*/

// inputs
detectInputs();

// display
var prevInputs = inputsArray;
var prevDir = dir;

inputsArray = [0,0,0,0];

dir = InputDirection(360,INPUT_CLUSTER.NAVIGATION) div 45; 
 
if InputCheckMany(inputsToCheck)
{
	for (var i = 0; i < array_length(inputsToCheck); i ++)
	{
		var thisInput = InputCheck(inputsToCheck[i]);
		inputsArray[i] = thisInput;
	}
}

var currInputs = inputsArray;
var currDir = dir;
var fullCurrentInputs = [currDir, currInputs]

if (inputs[0][1] != currDir) or !array_equals(currInputs,prevInputs)
{
	array_insert(inputs, 0, [inputsHeldTimer, currDir, currInputs]);
	inputsHeldTimer = 1;
}
else
{
	if inputsHeldTimer < 99 {inputsHeldTimer++};
	inputs[0] = [inputsHeldTimer, currDir, currInputs]
}

if array_length(inputs) >= linesMax {array_resize(inputs,linesMax);}

