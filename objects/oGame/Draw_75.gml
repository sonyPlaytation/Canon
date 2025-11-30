if global.piratedCopy draw_text(RES_W/2, RES_H/2, "YARRRR")
if nowSaving
{
	draw_sprite(sSaveIcon,0,GAME_W-24,GAME_H-24)
}

if !DEV exit;
    
if listActive {
    
    draw_set_color(c_black)
    draw_set_alpha(0.85)
    draw_rectangle((GAME_W/3)-menuXoffset,0,(GAME_W * 0.66)-menuXoffset,GAME_H,false)
    draw_set_alpha(1)
    
    draw_set_text(fSmart,c_black,fa_center,fa_top)
    draw_text((GAME_W/2)-menuXoffset-1,24+1,"ROOM SELECT");
    
    draw_set_color(c_reddish)
    draw_text((GAME_W/2)-menuXoffset,24,"ROOM SELECT");
    
    for(var i = 0; i < listLength; i++) {
        
        var thisroom = roomList[i];
        var drawX = ((GAME_W/3) + 6) -menuXoffset;
        var drawy = 48 + (i*14);
        
        // room list black bg
        draw_set_text(fSmall,c_black,fa_left,fa_middle)
        draw_text(drawX-1,drawy+1,room_get_name(thisroom))
        
        if cursorPos == i {
            
            // tags
            var tags = asset_get_tags(thisroom)
            array_sort(tags,true)
            var tagsX = (GAME_W*0.66)-menuXoffset
            
            draw_set_halign(fa_right)
            draw_text(tagsX-7,48+1,"TAGS")
            
            draw_set_color(c_grey)
            draw_text(tagsX-6,48,"TAGS")
            
            for (var j = 0; j < array_length(tags); j++){
                
                draw_set_color(c_black)
                draw_text(tagsX-7,48 + ((j+1)*14) +1,tags[j])
                
                draw_set_color(c_grey)
                draw_text(tagsX-6,48 + ((j+1)*14),tags[j])
            }
            //draw_sprite(screeny,1,GAME_W * 0.66, GAME_H/3);
            
            draw_sprite(sOptionArrow, 0, drawX, drawy)
            draw_set_color(c_yellow)
        } else{
            draw_set_color(c_dkgrey)
        }
        
        // room list text main
        draw_set_halign(fa_left)
        draw_text(drawX,drawy,room_get_name(thisroom))
        
    }
}