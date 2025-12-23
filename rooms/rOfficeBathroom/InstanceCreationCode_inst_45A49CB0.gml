myScript = function(){ 
    
    if oPlayer.going and oPlayer.facing == 1 {
        
        with oBathroomStall {
            if image_index == 0 {
                SFX snDoorClose
                image_index = 1
            }
        }
        oPlayer.going = false
    }
    
}