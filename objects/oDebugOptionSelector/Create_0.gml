
buttons = []

for (var i = 0; i < instance_number(oDebugMouseButton); ++i) 
{
    var _button = instance_find(oDebugMouseButton,i)
	array_push(buttons,_button)
}

currentSelection = 0

selected = buttons[currentSelection];

pressed = false;