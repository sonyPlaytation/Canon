
if global.debug
{
	draw_set_alpha(0.25)
	draw_set_color(c_aqua)
	draw_circle(x,y,hitBoxSize,false)
}

// background
alpha = lerp(alpha, alphaTarg, lerpSpeed)
draw_set_alpha(alpha)
draw_set_color(color)
draw_rectangle(midX-900,midY-500,midX+900,midY+500,false)
draw_set_alpha(1)

// circle bg
draw_set_color(c_black)
draw_set_alpha(alpha/5)
draw_circle(x,y,radius+3,false)

// circle ring trail
draw_set_color(c_lime)
draw_set_alpha(0.75)
draw_circle(x,y,prevRadius,true)

// circle ring
draw_set_alpha(1)
draw_circle(x,y,radius,true)

radius = lerp(radius,radiusTarg,lerpSpeed+0.1)
prevRadius = lerp(prevRadius, radius, lerpSpeed)

with (defender)
{
	event_perform(ev_draw,ev_draw_normal)
}

with (user)
{
	event_perform(ev_draw,ev_draw_normal)
}