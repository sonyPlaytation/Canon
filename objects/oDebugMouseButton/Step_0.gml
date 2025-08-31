
color = c_white

if position_meeting(global.mX,global.mY,id)
{
	color = c_yellow
	if mouse_check_button(mb_left)
	{
		this[doThis]()
	}
}