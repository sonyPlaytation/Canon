
if fogAlpha > 0
{
	draw_set_alpha(fogAlpha)
	
	gpu_set_fog((fogColor != noone),fogColor,0,1);
	draw_self();
	gpu_set_fog(false,c_white,bbox_top,bbox_bottom);
	
	draw_set_alpha(1)
}