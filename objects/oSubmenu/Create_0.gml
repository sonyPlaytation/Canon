/// @
hover = 0;
active = true;
subMenuLevel = 0;
actorName = ""

xTarg = x + 12;
lerpSpd = 0.25;
menuGap = 6

alpha = 0;
alphaTarg = 1;
alphaLerp = 0.2;

destroyMenu = false;

buildInfo = function(_x, _y, _info)
{
	draw_sprite(sBattleMoveDescBG, 0, _x, _y);
	
	draw_set_text(fSmall,c_white,fa_left, fa_top)
	
	draw_text_scribble(_x + 18, _y - 6, _info.desc)
	
	draw_text_scribble(_x + 18, _y + sprite_get_height(sBattleMoveDescBG)-40, _info.types)
	draw_text_scribble(_x + 18, _y + sprite_get_height(sBattleMoveDescBG)-24, _info.input)
}
