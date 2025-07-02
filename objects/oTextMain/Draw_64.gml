/// @

var xscale = 1;
if portSide == PORT_SIDE.R
{
	xscale = -1;
	portraitX = x + width;
}

var finished = (typist.get_state() >= 1)

draw_sprite_ext(sprite,emotion,portraitX,portraitY,xscale,1,0,c_white,1)
draw_sprite_stretched(sprite_index,boxSpr,x,y,width,height);

myName.draw(x + txtX, y - 12);
scribb.draw(x + txtX, y + txtY, typist);