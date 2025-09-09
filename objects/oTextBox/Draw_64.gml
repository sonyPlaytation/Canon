/// @

if onHold or !drawNow {exit}

if yMode == TXTPOS.BTM 
{
	alpha = approach(alpha,alphaTarg,alphaSpeed)
	draw_sprite_ext(sTextBgGradient,0,0,GAME_H,GAME_W,1,0,c_white,alpha/2)
	draw_set_alpha(alpha)
}

var xscale = 1;
portraitX = x;
if portSide == PORT_SIDE.R
{
	xscale = -1;
	portraitX = x + width;
}

if sprite != noone draw_sprite_ext(sprite,emotion,portraitX,portraitY,xscale,1,0,c_white,alpha)
draw_sprite_stretched(sprite_index,boxSpr,x,y,width,height);

if (yMode == TXTPOS.BTM and alpha == alphaTarg) or yMode != TXTPOS.BTM 
{

	var nameY = y - 26
	if name != ""
	{
		draw_sprite_stretched(sTextNameBox,boxSpr,x + (txtX/2), nameY, nameW * 2.1,24);
		myName.draw(x + txtX, nameY + 11);
	}
	scribb.draw(x + txtX, y + txtY, typist);

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