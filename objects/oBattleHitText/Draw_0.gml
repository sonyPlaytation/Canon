/// @
draw_set_text(font, color == c_lime ? c_green : c_black,fa_middle,fa_center)

if is_numeric(text){text = abs(text)}
draw_text(x+1,y+1,text)
draw_set_color(color)
draw_text(x,y,text)
draw_set_alpha(1)