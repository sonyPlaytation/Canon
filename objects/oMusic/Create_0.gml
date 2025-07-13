

global.forceSong = false;

//audio_group_load(Music)

//info for song we want to play
songInstance = noone;
songAsset = noone;
targetSongAsset = noone;
fadeOutTime = 0; //frames to fade song out for
fadeInTime = 0; //frames to fade in new song
fadeInInstVol = 1; //voluem of song instance


//for fading music out and stopping songs that are no longer playing

fadeOutInst = array_create(0); //the audio instances to fade out
fadeOutInstVol = array_create(0); //the volume of each audio instance
fadeOutInstTime = array_create(0); //speed of fadeout


//Now Playing Messages
playingMsg = "TESTEST"
alpha = 0;

fadeTarg = 0;
playingFade = 0;
holdTime = 360;
fadeDone = false;

msgX = RES_W/2;
msgY = RES_H;

