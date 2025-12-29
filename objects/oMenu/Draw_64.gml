/// @

var page = options[$ currentMenu]
var item = page[hover]

var optionsCount = array_length(page);
height = lineHeight * optionsCount;
heightFull = height + (ymargin * 2);

draw_sprite(sBattleOptionHeader, 0, x,y);
draw_set_text(fSmall,c_white,fa_left, fa_middle);

var scrollPush = max(0, hover - (visibleOptionsMax-1));

for (var l = 0; l < visibleOptionsMax; l++) {
    
	if l >= optionsCount {break;}
	if active {draw_set_color(c_white)} else draw_set_color(c_dkgrey)

	var optionToShow = l - scrollPush;
	var selected = (hover == optionToShow)
	
	var optY = y + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1))
	var optX = x + (12*selected)
	
	draw_sprite(sBattleOptions,selected, optX, optY);
	
	var str = page[optionToShow].name;
		
	if page[optionToShow].allowed == false {draw_set_color(c_grey);}
	
	if selected 
	{ 
		draw_set_color(c_black)
		draw_text(optX+xmargin-1, optY+ymargin, str)
		draw_text(optX+xmargin, optY+ymargin+1, str)
		draw_text(optX+xmargin-1, optY+ymargin+1, str)
		draw_set_color( #ff4194 ); 
		if active draw_sprite(sBattleMenuMainArrow, 0, optX, optY+ymargin);
		selectY = optY;
	}
	
	draw_text(optX+xmargin, y+ymargin + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1)), str)	

}