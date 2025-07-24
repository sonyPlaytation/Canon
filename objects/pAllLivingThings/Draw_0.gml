/// @

if global.debug 
{

	draw_set_color(c_black)
	draw_circle(x,y,6,false)
	draw_set_color(c_white)
	draw_circle(x,y,5,false)
	
	draw_set_color(c_lime)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)
	
}