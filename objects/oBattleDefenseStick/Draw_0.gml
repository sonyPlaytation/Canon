
//draw_set_color(c_red)
//draw_circle(homeX,homeY,dist/5,false)
//draw_set_color(c_black)
//draw_circle(homeX,homeY,dist/5,true)

if flash > 0 {shader_set(shWhiteFlash)}
if hit > 0 {shader_set(shRedFlash)}

draw_trail(12,6,c_white,-1,true,image_alpha)

draw_self();

shader_reset()

if global.debug draw_sprite(sHeadHitbox,0,x,y)
