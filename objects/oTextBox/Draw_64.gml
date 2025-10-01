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
	var _side = PORT_SIDE.L
	var portX;
	// left portraits
	xscale = 1
	for (var l = array_length(speaker[_side])-1; l >= 0 ; l--)
	{
		var _spkr = speaker[_side][l]
		if l == 0 and activeSpeaker == _side {portcolor = c_white} else portcolor = c_dkgrey;
		
		portSlide[_side] = lerp(portSlide[_side],0,0.1);
		if l != 0 
		{
			
			portX = portraitX[_side] - ((150/array_length(speaker[_side]))*(l-portSlide[_side]))
		} 
		else 
		{

			portX = portraitX[_side] - ((150/array_length(speaker[_side]))*l);
		}
		
		if l == 0 _spkr.y = lerp(_spkr.y,0,0.2) else _spkr.y = 0
		
		if speaker[_side][l] != noone 
		{	
			_spkr.alpha = approach(_spkr.alpha,1,alphaSpeed)
			draw_sprite_ext(_spkr.sprite, _spkr.emotion, portX, portraitY + _spkr.y,xscale - (shrinkSize*(l-portSlide[_side])),1 - (shrinkSize*(l-portSlide[_side])),0,portcolor,speaker[_side][l].alpha);
		}
	}

	_side = PORT_SIDE.R
	// right portraits
	xscale = -1
	for (var r = array_length(speaker[_side])-1; r >= 0 ; r--)
	{
		var _spkr = speaker[_side][r]
		if r == 0 and activeSpeaker == _side {portcolor = c_white} else portcolor = c_dkgrey;
		
		portSlide[_side] = lerp(portSlide[_side],0,0.1);
		if r != 0 {portX = portraitX[_side] - (75*(r-portSlide[_side]))} else portX = portraitX[_side] - (75*r);
		if r == 0 _spkr.y = lerp(_spkr.y,0,0.2) else _spkr.y = 0
		
		if speaker[_side][r] != noone 
		{
			_spkr.alpha = approach(_spkr.alpha,1,alphaSpeed)
			draw_sprite_ext(_spkr.sprite, _spkr.emotion, portX, portraitY + _spkr.y,xscale + (shrinkSize*(r-portSlide[_side])),1 - (shrinkSize*(r-portSlide[_side])),0,portcolor,speaker[_side][r].alpha);
		}
	}
}

draw_sprite_stretched(sprite_index,boxSpr,x,y,width,height);

if (yMode == TXTPOS.BTM and alpha == alphaTarg) or yMode != TXTPOS.BTM 
{
	draw_set_font(font);
	var nameY = y - 24
	if name != "" and activeSpeaker != -1
	{
		var _txtXFinal;
		switch (activeSpeaker)
		{
			case PORT_SIDE.L: _txtXFinal = x + (txtX/2) break;
			case PORT_SIDE.R: _txtXFinal = x + width - sprite_get_width(sBattleOptions) - (txtX/2) break;
		}
		draw_sprite(sBattleOptions,0,_txtXFinal, nameY);
		myName.draw(_txtXFinal+6, nameY + 8);
	}
	
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