for (var i = 0; i < image_number; i++)
{
    if i == image_number-1 {draw_sprite_stretched(sprite_index,i,global.cam.get_x(),yArr[i]+sprite_height,room_width,room_height/2);} 
    else draw_sprite_tiled(sprite_index,i,xArr[i]+(scroll*i),yArr[i]+1);
    
}