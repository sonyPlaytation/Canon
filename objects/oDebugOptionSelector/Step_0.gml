
with selected
{
	color = c_yellow
}

if currentSelection < (array_length(buttons)-1) and InputPressed(INPUT_VERB.DOWN) {currentSelection++}
if currentSelection > 0 and InputPressed(INPUT_VERB.UP) {currentSelection--}

selected = buttons[currentSelection];
x = selected.bbox_left
y = selected.y+12;

if InputPressed(INPUT_VERB.ACCEPT)
{
	with selected
	{
		options[$ doThis].func()
	}
}