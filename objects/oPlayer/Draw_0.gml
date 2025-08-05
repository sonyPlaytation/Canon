/// @

// Inherit the parent event
event_inherited();

draw_sprite_ext(sprite_index,image_index,x,y-z,drawXScale,drawYScale,rot,color,alpha);

if global.debug
{
	draw_text(x,y+12,x)
	draw_text(x,y+24,y)
	draw_text(x,y+36,xprevious)
	draw_text(x,y+48,yprevious)

	var xTo, yTo

	xTo = lengthdir_x(24,point_direction(xprevious, yprevious,x, y))
	yTo = lengthdir_y(24,point_direction(xprevious, yprevious,x, y))

	draw_line(x,y,x+xTo,y+yTo)
}