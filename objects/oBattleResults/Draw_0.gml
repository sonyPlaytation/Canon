

//Background darken
bgAlpha = lerp(bgAlpha,bgAlphaTarg,0.24);
draw_set_alpha(bgAlpha)
draw_set_color(bgCol)
draw_rectangle(x-100,y-100,x+GAME_W,y+GAME_H,false)
draw_set_alpha(1)
draw_set_color(c_white)

// draw height of the main box
h = approach(h,hTarg,min(hSpeed,abs(h-hTarg)))
draw_sprite_stretched(sTextBox,0,x,y,w,h)


if h >= hTarg-1
{
	draw_set_text(fSmart,c_white,fa_center,fa_middle)
	draw_text(scrWhalf,y+pad2,"BATTLE RESULTS")
	
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	
	draw_sprite_stretched(sTextBox,1,quoteX,quoteY,quoteW,quoteH)
	draw_text_scribble(scrWhalf,quoteY+pad2,winQuote)
	
	draw_set_text(fSmall,c_white,fa_left,fa_top)
	
	for (var i = 0; i < array_length(PARTY); i++)
	{
		var ThisBoxX = boxX + (boxW * i) + (pad2*i)
		var ThisPort = sBattlePort
		
		draw_sprite_stretched(sTextBox,1,ThisBoxX,boxY,boxW,boxH)
		draw_sprite(ThisPort,i,ThisBoxX+pad3,boxY+pad3)
		
		draw_text(ThisBoxX + pad2 + sprite_get_width(ThisPort), boxY+pad3, $"{PARTY[i].name}\n{PARTY[i].job}")
	}
}