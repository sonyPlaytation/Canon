/// @

if song != -1
{
	if mainSong
	{ playSong(song,fadeOutTime,fadeInTime) }
	else { playSong(song,fadeOutTime,fadeInTime,true) }
}