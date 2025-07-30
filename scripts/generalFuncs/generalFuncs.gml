
global.songPlaying = noone;
global.drawShadows = true;

function playerSetup(){
	
	// Movement and Collision
	iFrames = 0;
	hasControl = true;
	hsp = 0;
	vsp = 0;
	walksp = 2;
	runsp = 3;
	dir = 0;
	onGround = true;
	tiles = layer_tilemap_get_id("CollTiles");
	JustHitEnemyButCanStillMoveALittleReset = 45;
	JustHitEnemyButCanStillMoveALittle = JustHitEnemyButCanStillMoveALittleReset;
	
	colls = [oColl,pNPC,tiles];
	
	//animation
	going = 0;
	facing = FACING.DOWN;
	face = [];
	
	// drawing
	drawXScale = 1
	drawYScale = 1
	rot = 0
	color = c_white 
	alpha = 1

	// Followers
	followLength = 48
	for (var i = followLength-1; i >= 0 ; i--)
	{
		face[i] = facing;
		posX[i] = x;
		posY[i] = y;
		sprSpd[i] = image_speed;
	}

	//cFollow = true;
	cDist = 16;
	Charlie = noone;

	//mFollow = true;
	mDist = cDist + 18;
	Matthew = noone;

	diagFix = false;
	
	// State Specific
	dashCharge = 0;
	dashFrames = 40;
	dashReset = 15
	dashTime = dashReset;
	dashH = 0;
	dashV = 0;
	dashSpd = 6;
	z = 0;
	grv = 0.3
	zsp = 0;
}

function draw_character_shadow()
{
	if global.drawShadows
	{
		var halfw = sprite_width/2
		draw_set_color(c_black);
		draw_set_alpha(0.5);
		draw_ellipse(floor(x-halfw)-1,floor(y-6),ceil(x+halfw),ceil(y+6),false);
		draw_set_alpha(1);	
	}
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