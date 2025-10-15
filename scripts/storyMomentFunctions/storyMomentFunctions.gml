function lostInDesert(){
    if instance_exists(oPlayer)
    {
        oGame.lostAsFuck++; 
        oPlayer.canRun = false; 
        oPlayer.walksp -= 0.1;
        
        if oGame.lostAsFuck >= 5{
            SFX snFunnyFart
        }
    }
}