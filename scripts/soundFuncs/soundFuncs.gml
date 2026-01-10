
#region sound loop definitions

	audio_sound_loop_start(mBattleWin,1.09)
	audio_sound_loop_start(mBattleNeut,7.63)
	audio_sound_loop_start(mGwenIntro,27.82)

#endregion

/// @function					playSong()
/// @description				Changes the song you want to play next, with fade in and out times.
/// @param {Real}	song		The song you want to play.
/// @param {Real}	fadeOut		The time it should take to fade out, counted in frames.
/// @param {Real}	fadeIn		The time it should take to fade in, counted in frames.
/// @param {bool}	tempSong	Should this song pause the main area theme or not.
/// @returns {asset} currentSong current song playing.
function playSong(_song = noone, _fadeOut = 10, _fadeIn = 0) {
	
		//_song to set any song (including noone to stop
		//_fadeOut to fade out in frames
		//_fadeIn to fade in in frames
	
	var newSong = new Song(_song,_fadeOut, _fadeIn)
	
	
	with (oMusic) {
		
		if is_undefined(playStack){playStack = []}
		
		array_push(playStack,newSong)
		
		
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

function Song(_song, _fadeOut, _fadeIn) constructor{
	
	song = _song;
	fadeOut = _fadeOut;
	fadeIn = _fadeIn;
	vol = (fadeIn > 0) ? 1/fadeIn : 0;
	playHead = 0;
	
	
	
}

function end_temp_song(_fadeOut = 10, _fadeIn = oMusic.fadeInTime)
{
	with oMusic
	{
		if audio_is_paused(songAsset) or !audio_is_playing(songAsset)
		{
			audio_stop_sound(tempSongAsset)
			tempSongAsset = noone;
			if audio_is_paused(songAsset) 
			{
				audio_resume_sound(songAsset)
				audio_sound_gain(songAsset,0.5,_fadeIn)
			}
			
		}	
	}
}

function updatevolume()
{
    global.musVol = SETTINGS.sound.musicVolume * SETTINGS.sound.masterVolume * SETTINGS.sound.mute;
    global.sfxVol = SETTINGS.sound.sfxVolume * SETTINGS.sound.masterVolume * SETTINGS.sound.mute;
    global.voiceVol = SETTINGS.sound.voiceVolume * SETTINGS.sound.masterVolume * SETTINGS.sound.mute;
}