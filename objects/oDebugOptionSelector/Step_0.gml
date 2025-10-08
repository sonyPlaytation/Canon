if instance_exists(oTextBox) exit;

if !pressed
{
	// stupid bandaid fix so i can have a 
	buttons = []

	for (var i = 0; i < instance_number(oDebugMouseButton); ++i) 
	{
	    var _button = instance_find(oDebugMouseButton,i)
		array_push(buttons,_button)
	}
	
	array_sort(buttons, function(e1,e2){
		return e1.y - e2.y
	});

	with selected
	{
		color = c_yellow
	}

	if currentSelection < (array_length(buttons)-1) and InputPressed(INPUT_VERB.DOWN) {currentSelection++}
	if currentSelection > 0 and InputPressed(INPUT_VERB.UP) {currentSelection--}

	selected = buttons[min(currentSelection,array_length(buttons)-1)];
	x = selected.bbox_left
	y = selected.y+12;

	if InputPressed(INPUT_VERB.ACCEPT)
	{
		with selected
		{
			options[$ doThis].func()
		}
		//if selected.doThis !="wipeSave" pressed = true
	}
}