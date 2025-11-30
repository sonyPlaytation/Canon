/// @

bgspeed += 1
bgx += clamp(bgspeed,-4,4)

if instance_exists(oBattle) exit;

if !surface_exists(surf) {surf = surface_create(RES_W,RES_H);}
	
if !global.pauseEvery 
{
	if fade {alpha = lerp(alpha,0,0.01)}
	var targX, targY
	if instance_exists(follow)
	{
		targX = global.cam.room_to_gui_x(follow.x);
		targY = global.cam.room_to_gui_y(follow.y);
	}
	else 
	{
		targX = global.mX;
		targY = global.mY;
	}
	
	surface_set_target(surf);
	
	var xx,yy;
	
	xx = global.cam.x - oCamera.resWHalf
	yy = global.cam.y - oCamera.resHHalf
	
	var alph = 0.98
	draw_set_alpha(1)
	draw_sprite_tiled(bgSand,0,bgx,bgx);
    draw_set_alpha(0.1)
	
    draw_set_color(c_black)
	draw_rectangle(0,0,RES_W,RES_H,false)

	for (var i = 0; i < waveRate; i++)
	{
		pinSize = irandom_range(40,42) + (i * 12)
		draw_set_alpha(0.15)
		gpu_set_blendmode(bm_subtract)
		draw_circle(targX,targY-12,pinSize,false)
		gpu_set_blendmode(bm_normal)
	}

	surface_reset_target();
}

draw_set_alpha(alpha)
draw_surface(surf,0,0)

//if instance_exists(oTextBox)
//{
//	oTextBox.visible = false;
//	event_perform_object(oTextBox,ev_gui)
//}