/// @

depth = -bbox_bottom;

groundMove();

if (x != xprevious or y != yprevious)
{
	for (var i = followLength-1; i > 0 ; i--)
	{
		posX[i] = posX[i-1];
		posY[i] = posY[i-1];	
	}
	
	posX[0] = x;
	posY[0] = y;
}