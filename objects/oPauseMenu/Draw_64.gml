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
draw_text(x+xmargin, sprite_get_height(sBattleOptionHeader)-12, currentMenu ); 
draw_set_font(fSmall)

for (var l = 0; l < optionsCount ; l++)
{
	if l >= optionsCount {break;}
	if active {draw_set_color(c_white)} else draw_set_color(c_dkgrey)

	var selected = (hover == l)
	
	var optY = y+ sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1))
	var optX = x + (12*selected)
	
	draw_sprite(sBattleOptions,selected, optX, optY);
	
	var str = options[$ currentMenu][l].label;	
	if !options[$ currentMenu][l].allowed {draw_set_color(c_grey);}
	
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
	else
	{
		//var scale = RES_W div GAME_W
		//gpu_set_scissor(optX*scale,optY*scale,(sprite_get_width(sBattleOptions))*scale,(sprite_get_height(sBattleOptions)-1)*scale)
		//draw_set_color(c_red)
		//draw_rectangle(0,0,GAME_W,GAME_H,false)
		//draw_set_color(c_dkgrey)
		//gpu_set_scissor(0,0,RES_W,RES_H);	
	}
	
	draw_text(optX+xmargin, y+ymargin + sprite_get_height(sBattleOptionHeader) + (sprite_get_height(sBattleOptions)*l) + (menuGap*(l+1)), str)	
	
}

