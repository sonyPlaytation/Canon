/// @

if song != -1
{
	if mainSong
	{ set_song_ingame(song,fadeOutTime,fadeInTime) }
	else { set_song_ingame(song,fadeOutTime,fadeInTime,true) }
}