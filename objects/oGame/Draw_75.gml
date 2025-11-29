if global.piratedCopy draw_text(RES_W/2, RES_H/2, "YARRRR")
if nowSaving
{
	draw_sprite(sSaveIcon,0,GAME_W-24,GAME_H-24)
}

if listActive {
    
    draw_set_color(c_black)
    draw_set_alpha(0.85)
    draw_rectangle(GAME_W/3,0,GAME_W * 0.66,GAME_H,false)
    draw_set_alpha(1)
    
    draw_set_text(fSmart,c_reddish,fa_center,fa_top)
    draw_text(GAME_W/2,24,"ROOM SELECT");
    
    for(var i = 0; i < listLength; i++) {
        
        draw_set_text(fSmall,c_white,fa_left,fa_middle)
     
        var drawX = (GAME_W/3) + 6;
        var drawy = 48 + (i*14);
        
        if cursorPos == i {
            draw_sprite(sOptionArrow, 0, drawX, drawy)
            draw_set_color(c_yellow)
        } else{
            draw_set_color(c_dkgrey)
        }
        
        draw_text(drawX,drawy,room_get_name(roomList[i]))
        draw_text(drawX,drawy,room_get_name(roomList[i]))
        
    }
}