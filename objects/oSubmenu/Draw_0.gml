/// @

draw_set_alpha(alpha)
alpha = lerp(alpha,alphaTarg,alphaLerp);

var optionsCount = array_length(options);

draw_set_text(fSmall,c_white,fa_left, fa_middle);

var _desc = (desc != -1);
var scrollPush = max(0, hover - (visibleOptionsMax-1));

for (var l = 0; l < visibleOptionsMax + _desc; l++)
{
	if l >= array_length(options) {break;}
	if active {draw_set_color(c_white)} else draw_set_color(c_dkgrey)

	var optionToShow = l - _desc + scrollPush;
	var info = options[optionToShow][4]
	var selected = (hover == optionToShow - _desc)
	
	var optY = y + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1)) - 6
	var optX = x + (12*selected)
	
	draw_sprite(sBattleOptions,selected, optX, optY);

	var str = options[optionToShow][0];
		
	if options[optionToShow][3] == false {draw_set_color(c_grey);}
	
	if selected 
	{ 
		draw_set_color(c_black)
		draw_text(optX+xmargin-1, optY+ymargin, str)
		draw_text(optX+xmargin, optY+ymargin+1, str)
		draw_text(optX+xmargin-1, optY+ymargin+1, str)
		
		if active draw_sprite(sBattleMenuMainArrow, 0, optX, optY+ymargin);
		
		if info != undefined 
		{ 
			buildInfo(optX + sprite_get_width(sBattleOptionHeader), optY+ymargin, info) 
			draw_set_valign(fa_middle)
		}
		
		draw_set_color( #ff4194 ); 
	}
	
	draw_text(optX+xmargin, optY+ymargin, str)	
}

if (visibleOptionsMax < array_length(options) and hover < array_length(options)-1)
{
	draw_sprite(sMenuArrow,3,x + TILE_SIZE*4, y + heightFull+2)	
}

draw_set_alpha(1)