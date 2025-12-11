/// @

draw_set_color(c_black)
alpha = lerp(alpha, alphaTarg, 0.15);
draw_set_alpha(alpha)
draw_rectangle(-10,-10,GAME_W,GAME_H,false);
draw_set_alpha(1)

var optionsCount = array_length(options[$ currentMenu]);
height = lineHeight * optionsCount;
heightFull = height + (ymargin * 2);

draw_sprite(sBattleOptionHeader, 0, x,y); 
draw_set_text(fSmart,c_white,fa_left, fa_middle);

var menuHeaders = 3
for (var i = min(array_length(prevMenus)-1,menuHeaders); i >= 0; i--) {
	draw_set_alpha((0.65/(i+1)))
	{draw_text_transformed(x+xmargin, (sprite_get_height(sBattleOptionHeader)-26) - (14*i) , prevMenus[array_length(prevMenus)-i-1].menu,1,1,0); }
	draw_set_alpha(1)
}
draw_text(x+xmargin, sprite_get_height(sBattleOptionHeader)-12, currentMenu ); 

for (var l = 0; l < optionsCount ; l++)
{
    draw_set_font(fSmall);
    draw_set_halign(fa_left)
    
    var listItem = options[$ currentMenu][l]
	if l >= optionsCount {break;}
	if active {draw_set_color(c_white)} else draw_set_color(c_dkgrey)

	var selected = (hover == l)
	
	var optY = y + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1))
	var optX = x + (12*selected)
	
	draw_sprite(sBattleOptions,selected, optX, optY);
	
	var str = listItem.name;	
	if !listItem.allowed {draw_set_color(c_grey);}
	
	if selected 
	{ 
		draw_set_color(c_black)
		draw_text(optX+xmargin-1, optY+ymargin, str)
		draw_text(optX+xmargin, optY+ymargin+1, str)
		draw_text(optX+xmargin-1, optY+ymargin+1, str)
		draw_set_color( c_highlight ); 
		if active draw_sprite(sBattleMenuMainArrow, 0, optX, optY+ymargin);
		selectY = optY;
	}
	
	draw_text(optX+xmargin, optY+ymargin, str)	
    if listItem[$ "draw"] != undefined {
		listItem.draw(optX+xmargin - (12*selected), optY+ymargin, selected, listItem.value)
	};
	
}

