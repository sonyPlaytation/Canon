/// @
var _offset = 20
draw_set_text(fSmall,c_black,fa_left,fa_middle)
for (var i = 0; i < array_length(global.myItems); i++)
{
	draw_sprite(global.myItems[i].sprite, 0, 24,24 + (i*_offset))
	draw_text(38,24 + (i*_offset),global.myItems[i].name)
}