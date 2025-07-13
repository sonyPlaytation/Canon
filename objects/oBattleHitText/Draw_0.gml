/// @
draw_set_font(font)
draw_set_alpha(alpha)
draw_set_color(c_black)

if is_numeric(text){text = abs(text)}
draw_text(x+1,y+1,text)
draw_set_color(color)
draw_text(x,y,text)
draw_set_alpha(1)