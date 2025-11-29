/// @

draw_character_shadow(min(sprite_width,24),sprite_height);

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

draw_healthbar(x-18,y-sprite_height-4,x+18,y-sprite_height-6,(stats.hp/stats.hpMax)*100,c_black,c_red,c_lime,0,true,false)