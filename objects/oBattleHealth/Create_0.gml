
_x = global.cam.get_x() + 12
_y = global.cam.get_y() + 12

depth = oBattle.depth-100

if !enemy
{
	x = _x;
	y = _y;

	hpx = _x + 8
	hpy = _y + 8

	headx = _x + 19
	heady = _y + 34

	hp = oBattle.partyHP
	hpMax = oBattle.partyHPMAX;
	hpPercent = (hp/hpMax)

	wMax = 250
	w = wMax * hpPercent
	nameXoffset = 58;
}
else
{
	_x = global.cam.get_x()	+ (GAME_W - sprite_width - 12);
	_y = global.cam.get_y()	+ 12;
	
	x = _x 
	y = _y 

	hpx = x + 7
	hpy = y + 8

	headx = _x + 246
	heady = _y + 34

	hp = oBattle.enemyHP
	hpMax = oBattle.enemyHPMAX;
	hpPercent = (hp/hpMax)

	wMax = 250
	w = wMax * hpPercent
	image_index = 1
}

frame = 0; // which frame the hp sprite is on
introDone = false
alarm[0] = 60
headFrame = 0;