/// @

draw_sprite_stretched(sTextBox, 0, x,y, widthFull, heightFull);
draw_set_text(fSmall,c_white,fa_left, fa_top);

var _desc = desc != -1;
var scrollPush = max(0, hover - (visibleOptionsMax-1));

for (var l = 0; l < visibleOptionsMax + _desc; l++)
{
	if l >= array_length(options) {break;}
	draw_set_color(c_white);
	if l == 0 and _desc
	{
		draw_text(x + xmargin, y + ymargin, _desc);
	}
	else
	{
		var optionToShow = l - _desc + scrollPush;
		var str = options[optionToShow][0];
		if (hover == optionToShow - _desc)
		{
			draw_set_color(c_yellow);
		}
		if options[optionToShow][3] == false {draw_set_color(c_grey);}
		draw_text(x + xmargin, y + ymargin + (l*lineHeight), str)
	}
}

draw_sprite(sOptionArrow, 0, x + xmargin, y + ymargin + ((hover - scrollPush) * lineHeight)+7);

if (visibleOptionsMax < array_length(options) and hover < array_length(options)-1)
{
	draw_sprite(sMenuArrow,3,x + widthFull * 0.95, y + heightFull - 7)	
}