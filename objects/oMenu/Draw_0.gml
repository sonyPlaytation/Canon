/// @


var optionsCount = array_length(options);
height = lineHeight * (optionsCount + (desc != -1));
heightFull = height + (ymargin * 2);

draw_sprite(sBattleOptionHeader, 0, x,y);
draw_set_text(fSmall,c_white,fa_left, fa_middle);

var _desc = (desc != -1);
var scrollPush = max(0, hover - (visibleOptionsMax-1));

for (var l = 0; l < visibleOptionsMax + _desc; l++)
{
	if l >= array_length(options) {break;}
	draw_set_color(c_white);

	var optionToShow = l - _desc + scrollPush;
	var selected = (hover == optionToShow - _desc)
	
	var optY = y + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1))
	
	draw_sprite(sBattleOptions,selected, x, optY);

	var str = options[optionToShow][0];
		
	if options[optionToShow][3] == false {draw_set_color(c_grey);}
	
	if selected 
	{ 
		draw_set_color(c_black)
		draw_text(x+xmargin-1, optY+ymargin, str)
		draw_text(x+xmargin, optY+ymargin+1, str)
		draw_text(x+xmargin-1, optY+ymargin+1, str)
		draw_set_color( #ff4194 ); 
		draw_sprite(sBattleMenuMainArrow, 0, x, optY+ymargin);
	}
	
	draw_text(x+xmargin, y+ymargin + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1)), str)	
}

if (visibleOptionsMax < array_length(options) and hover < array_length(options)-1)
{
	draw_sprite(sMenuArrow,3,x + widthFull * 0.95, y + heightFull - 7)	
}