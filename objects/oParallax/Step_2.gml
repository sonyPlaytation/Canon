for (var i = 0; i < image_number; i++)
{
    xArr[i] = global.cam.get_x() / (i+1);
    yArr[i] = TILE_SIZE + global.cam.get_y() / (i+5);
}
if !global.pauseEvery {scroll+=0.05}