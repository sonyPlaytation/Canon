/// @

draw_character_shadow();

if flash > 0
{
	flash--;
	gpu_set_fog(true,  flashCol, 0, 1000)
	draw_self();
	gpu_set_fog(false, flashCol, 0, 1000)
}
else
{
	draw_self();
}


if global.debug 
{
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	draw_text(x,y+5,$"{hp}/{hpMax}")	
}