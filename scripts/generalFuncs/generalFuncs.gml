
global.songPlaying = noone
/// @function					set_song_ingame()
/// @description				Changes the song you want to play next, with fade in and out times.
/// @param {Real}	song		The song you want to play.
/// @param {Real}	fadeOut		The time it should take to fade out, counted in frames.
/// @param {Real}	fadeIn		The time it should take to fade in, counted in frames.
/// @param {String}	message		"Now Playing" Message.
/// @param {Real}	messageFade Message fade fime, counted in frames.
/// @returns					N/A
function set_song_ingame(_song, _fadeOut = 0, _fadeIn = 0, _msg = "", _msgFade = 60)
{
		//_song to set any song (including noone to stop
		//_fadeOut to fade out in frames
		//_fadeIn to fade in in frames
	show_debug_message(audio_get_name(_song))
	global.songPlaying = _song
	with (oMusic)
	{
		targetSongAsset = _song;	
		fadeOutTime = _fadeOut;
		fadeInTime = _fadeIn;
		playingMsg = _msg;
		playingFade = _msgFade; 
	}
}

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
	facing = 1;
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

	cFollow = true;
	cDist = 16;
	Charlie = noone;

	mFollow = true;
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
	var halfw = sprite_width/2
	draw_set_color(c_black);
	draw_set_alpha(0.5);
	draw_ellipse(round(x-halfw),round(y-6),round(x+halfw),round(y+6),false);
	draw_set_alpha(1);	
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