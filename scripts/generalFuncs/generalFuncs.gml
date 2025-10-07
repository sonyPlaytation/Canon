
global.songPlaying = noone;
global.drawShadows = true;

scribble_font_bake_shadow("fSmall", "fBattle",1,0,c_black,1,0,false);
scribble_font_bake_shadow("fQuit","nameFontMod",1,1,c_black,1,0,false)

function parryFlash(_frame)
{
	if _frame > 0
	{
		shader_set(shParryBlue); 
		var uniform_time = shader_get_uniform(shParryBlue, "frame")
		shader_set_uniform_f(uniform_time, _frame)
	}
}

function flashScreen(_color = c_white, _sound = -1, _fadeRate = 0.1)
{
	if _sound != -1
	{
		global.musVol = 0.25;
		call_later(audio_sound_length(_sound),time_source_units_seconds,function()
		{
			global.musVol = 1;
		})	
	}
	
	instance_create_depth(0,0,0,oScreenFlash,
	{
		color : _color,
		sound : _sound,
		fadeRate : _fadeRate
	})
}

function startCutscene(_scene, _x = oCutsceneAnchor.x, _y = oCutsceneAnchor.y)
{
	with pAllLivingThings {state = stateInCutscene;}
	instance_create_depth(_x,_y,depth,oCutCam)
	global.cam.follow = oCutCam;
	
	oInputReader.alphaTarg = 0;
	
	instance_create_depth(_x,_y,depth,oCutscene,
	{
		scene : _scene,
		trigger : other.id
	})
}

function playerSetup(){
	
	// Movement and Collision
	iFrames = 0;
	hasControl = true;
	hsp = 0;
	vsp = 0;
	walksp = 2;
	runspDefault = 2;
	runsp = runspDefault;
	runspMax = 3
	dir = 0;
	onGround = true;
	tiles = layer_tilemap_get_id("CollTiles");
	JustHitEnemyButCanStillMoveALittleReset = 45;
	JustHitEnemyButCanStillMoveALittle = JustHitEnemyButCanStillMoveALittleReset;
	
	//animation
	going = 0;
	facing = FACING.DOWN;
	face = [];
	gotoX = -1;
	gotoY = -1;
	inPosition = false;
	
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
	dashFrames = 20;
	dashReset = 5
	if FLAGS.chargeTackle dashReset = 15
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

/// @desc wave(from, to, duration, offset, time)
/// @arg from
/// @arg to
/// @arg duration
/// @arg offset
/// @arg time
function wave(from, to, duration, offset, time)
{
    var _wave = (to - from) * 0.5;
    return from + _wave + sin((((time * 0.001) + duration * offset) / duration) * (pi * 2)) * _wave;
}

function round_ext(_val, _decimal) 
{
    ///@desc	returns the rounded value to the number of decimal places passed
    ///@arg	real	value
    ///@arg	real	decimal to round to, 0.1 will be every 0.1, 0.5 will be every 0.5 increment

    return round(_val / _decimal) * _decimal;
}

function draw_set_text(font, color, halign, valign)
{
	draw_set_font(font);
	draw_set_color(color);
	draw_set_halign(halign);
	draw_set_valign(valign);
}

