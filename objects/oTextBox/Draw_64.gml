/// @

if onHold or !drawNow {exit}

if yMode == TXTPOS.BTM 
{
	alpha = approach(alpha,alphaTarg,alphaSpeed)
	draw_sprite_ext(sTextBgGradient,0,0,GAME_H,GAME_W,1,0,c_white,alpha/2)
	draw_set_alpha(alpha)
}


var xscale;
var portcolor = c_dkgrey;
var shrinkSize = 0.15

if speakersVisible
{
	// left portraits
	xscale = 1
	for (var l = array_length(speaker[PORT_SIDE.L])-1; l >= 0 ; l--)
	{
		var portXCurr = lerp(portraitX[PORT_SIDE.L],-50,1/l);
		var _spkr = speaker[PORT_SIDE.L][l]
		if l == 0 and activeSpeaker == PORT_SIDE.L {portcolor = c_white} else portcolor = c_dkgrey;
		if speaker[PORT_SIDE.L][l] != noone 
		draw_sprite_ext(_spkr.sprite, _spkr.emotion, portraitX[PORT_SIDE.L] - (75*l),portraitY,xscale - (shrinkSize*l),1 - (shrinkSize*l),0,portcolor,alpha);
	}

	// right portraits
	xscale = -1
	for (var r = array_length(speaker[PORT_SIDE.R])-1; r >= 0 ; r--)
	{
		var portXCurr = lerp(portraitX[PORT_SIDE.R],-50,1/r);
		var _spkr = speaker[PORT_SIDE.R][r]
		if r == 0 and activeSpeaker == PORT_SIDE.R {portcolor = c_white} else portcolor = c_dkgrey;
		if speaker[PORT_SIDE.R][r] != noone 
		draw_sprite_ext(_spkr.sprite, _spkr.emotion, portraitX[PORT_SIDE.R] + (75*r),portraitY,xscale + (shrinkSize*r),1 - (shrinkSize*r),0,portcolor,alpha);
	}
}

draw_sprite_stretched(sprite_index,boxSpr,x,y,width,height);

if (yMode == TXTPOS.BTM and alpha == alphaTarg) or yMode != TXTPOS.BTM 
{
	
	var nameY = y - 24
	if name != ""
	{
		nameW = string_width_scribble(name);
		draw_sprite(sBattleOptions,0,x + (txtX/2), nameY);
		myName.draw(x + txtX, nameY + 8);
	}
	draw_set_font(font);
	scribb.draw(x + txtX, y + txtY, typist); //main text rendering
	
	draw_set_font(font);
	var finished = (typist.get_state() >= 1)

	// Options
	if finished and optCount > 0
	{
		for (var i = 0; i < optCount; i++)
		{
			var _optX = x + optX + ((txtW / optCount) * i) + padding;
			var _optY = y + optY;
		
			var scropt = scribble(options[i].text)
				.starting_format(font_get_name(font),color)
				.align(fa_center,fa_middle)
		
			if i == currentOption
			{
				var arrowX = (_optX - (string_width(options[i].text)/2))
				draw_sprite(sOptionArrow,0,arrowX,_optY);	
			}
		
			scropt.draw(_optX, _optY)
		}
	}
}

draw_set_alpha(1)