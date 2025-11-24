function lostInDesert(){
    if instance_exists(oPlayer)
    {
        if oGame.lostAsFuck >= 5{
            audio_stop_sound(global.songPlaying);
            oPlayer.walksp = 0.5;
            
            var width = abs(bbox_right-bbox_left);
            var height = abs(bbox_top-bbox_bottom);
            
            instance_create_depth(x+(width/2),y+(width/2),depth,oCutsceneTrigger,{
                image_xscale : width/24,
                image_yscale : height/48,
                scene : cutFaintInDesertLost
            });
            
        } else {
            global.canPause = false;
            global.musicVolume -= 0.15
        	oGame.lostAsFuck++; 
            oPlayer.canDash = false; 
            oPlayer.canRun = false; 
            oPlayer.walksp -= 0.1;
            instance_destroy();
        }
    }
}