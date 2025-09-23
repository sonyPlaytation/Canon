/// @

if play != noone // this is what the SFX macro does
{
	var _sound = audio_play_sound(play,800,false,global.sfxVol);
	audio_sound_gain(_sound,global.sfxVol,0);
	play = noone;
}

if battlehit != noone
{
	var _sound = audio_play_sound(battlehit,800,false);
	audio_sound_gain(_sound,global.sfxVol,0);
	battlehit = noone;
}

if textSFX != noone
{
	var _sound = audio_play_sound(textSFX,800,false,global.sfxVol);
	audio_sound_gain(_sound,global.sfxVol,0);
	textSFX = noone;
}