/// @

walksp = 2;
follow = true;

caughtUp = false;

doFollow = function()
{
	var distOff = 2;
	
	if x <= oPlayer.posX[followDist] + distOff and x >= oPlayer.posX[followDist] - distOff
	and y <= oPlayer.posY[followDist] + distOff and y >= oPlayer.posY[followDist] - distOff
	{ caughtUp = true; }

	if oPlayer.going
	{
		if !caughtUp
		{
			x = approach(x, oPlayer.posX[followDist],walksp);
			y = approach(y, oPlayer.posY[followDist],walksp);
		}
		else
		{
			x = oPlayer.posX[followDist];
			y = oPlayer.posY[followDist];
		}
	}
	
	x = round(x);
	y = round(y);
}