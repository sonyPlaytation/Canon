/// @

draw_character_shadow();

if flash > 0 { flash--; shader_set(shWhiteFlash);}
if hit > 0   { hit--;   shader_set(shRedFlash);}
if parry > 0 { parry--;	parryFlash(parry); }

draw_self();
shader_reset();

if global.debug 
{
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	draw_text(x,y+5,$"{stats.hp}/{stats.hpMax}")	
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	draw_text(x,y+25,image_index)	
}

