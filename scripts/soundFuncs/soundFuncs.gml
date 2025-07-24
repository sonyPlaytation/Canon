/// @function					set_song_ingame()
/// @description				Changes the song you want to play next, with fade in and out times.
/// @param {Real}	song		The song you want to play.
/// @param {Real}	fadeOut		The time it should take to fade out, counted in frames.
/// @param {Real}	fadeIn		The time it should take to fade in, counted in frames.
/// @param {bool}	tempSong	Should this song pause the main area theme or not.
/// @returns {asset} currentSong current song playing.
function set_song_ingame(_song = noone, _fadeOut = 0, _fadeIn = 0, _tempSong = false)
{
		//_song to set any song (including noone to stop
		//_fadeOut to fade out in frames
		//_fadeIn to fade in in frames
	with (oMusic)
	{
		currentSong = _song;
		
		if _tempSong 
		{
			end_temp_song();
			tempSongAsset = _song;
		} else targetSongAsset = _song;		
		
		fadeOutTime = _fadeOut;
		fadeInTime = _fadeIn;
	}
	if global.songPlaying != _song 
	{
		show_debug_message($"NOW PLAYING: {audio_get_name(_song)}")
		global.songPlaying = _song
	}
	return global.songPlaying
}

function end_temp_song()
{
	with oMusic
	{
		if audio_is_paused(songAsset)
		{
			audio_stop_sound(tempSongAsset)
			tempSongAsset = noone;
			audio_resume_sound(songAsset)
			audio_sound_gain(songAsset,0.5,fadeInTime)
		}	
	}
}