/// @

audio_group_set_gain(agText,global.voiceVol,0)


if asset_get_type(play) == asset_sound // this is what the SFX macro does
{
	if audio_is_playing(play) audio_stop_sound(play)
	var _sound = audio_play_sound(play,800,false,global.sfxVol);
	audio_sound_gain(_sound,global.sfxVol,0);
	play = noone;
}

if battlehit != noone
{
	if audio_is_playing(battlehit) audio_stop_sound(battlehit)
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