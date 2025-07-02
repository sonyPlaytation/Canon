function playerSetup(){
	
	// Movement and Collision
	hsp = 0;
	vsp = 0;
	walksp = 2;
	runsp = 3;
	dir = 0;
	onGround = true;
	tiles = layer_tilemap_get_id("CollTiles");
	
	colls = [oColl,pEntity,tiles];

	// Followers
	followLength = 48
	for (var i = followLength-1; i >= 0 ; i--)
	{
		posX[i] = x;
		posY[i] = y;
	}

	cFollow = true;
	cDist = 16;
	Charlie = noone;

	mFollow = true;
	mDist = cDist + 18;
	Matthew = noone;

	diagFix = false;
}

/// @description scr_approach(start, end, shift);
/// @function scr_approach
/// @param start
/// @param end
/// @param shift
function approach( from, to, by)
{
	if (from < to) {
	   return min(from + by, to);
	} else {
	   return max(from - by, to);
	}
}

function draw_set_text(font, color, halign, valign)
{
	draw_set_font(font);
	draw_set_color(color);
	draw_set_halign(halign);
	draw_set_valign(valign);
}