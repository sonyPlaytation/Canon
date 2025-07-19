/// @

if instance_exists(oBattle) exit;

if !surface_exists(darkSurf) {darkSurf = surface_create(RES_W,RES_H);}
	
var targX, targY
if instance_exists(oPlayer)
{
	targX = global.cam.room_to_gui_x(oPlayer.x)
	targY = global.cam.room_to_gui_y(oPlayer.y)
}
else 
{
	targX = global.mX
	targY = global.mY
}
	
surface_set_target(darkSurf);
	
var xx,yy;
	
xx = global.cam.x - oCamera.resWHalf
yy = global.cam.y - oCamera.resHHalf
	
var alph = 0.94
draw_set_alpha(alph)
draw_set_color(c_black)
draw_rectangle(0,0,RES_W,RES_H,false)

for (var i = 0; i < 2; i++)
{
	var pinSize = irandom_range(40,42) + (i * 12)
	draw_set_alpha(0.45)
	gpu_set_blendmode(bm_subtract)
	draw_circle(targX,targY-12,pinSize,false)
	gpu_set_blendmode(bm_normal)
}
	
surface_reset_target();
	
draw_set_alpha(1)
draw_surface(darkSurf,0,0)


//if instance_exists(oTextBox)
//{
//	oTextBox.visible = false;
//	event_perform_object(oTextBox,ev_gui)
//}