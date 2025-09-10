

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

// post-battle stats
if screen == 0 and  h >= hTarg-1
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
else if screen == 1 //level up screen
{
	
	draw_set_color(c_orange)
	draw_rectangle(x-100,y-100,x+GAME_W,y+GAME_H,false)
	draw_set_text(fImpact,c_white,fa_left,fa_middle)
	
	draw_text(_x + 100,_y +50,"Points Left: " + string(skillPoints))
	if array_length(level) > 0 draw_sprite(sLevelNames, currentPartyMember, _x + 50, _y + (TILE_SIZE*5));
	
	for (var i = 0; i < array_length(stats[guyToLevel]); i++)
	{
		var stat = stats[guyToLevel][i]
		var base = baseStats[guyToLevel][i]
		var col = c_white
		var statX = _x + (TILE_SIZE*4) + (2*i)
		var statY = _y + (TILE_SIZE*6) + (14*i)
		
		if stat > base {col = c_red}
		
		if i == currentStat
		{
			draw_sprite(sMenuArrow,0,statX-24,statY)
			col = c_blue
		}
		
		// draw out the stats
		draw_set_color(c_black)
		draw_text(statX-1,statY+1,stats[guyToLevel][i])
		draw_set_color(col)
		draw_text(statX,statY,stats[guyToLevel][i])
		
		draw_sprite(sLevelUpStats,i,statX-10,statY)
	}
	
	draw_sprite(sBattlePort, currentPartyMember, _x + GAME_W*0.666, global.screenHalfY)
}							  