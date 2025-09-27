
alpha = approach(alpha,0,fadeRate)

draw_set_color(color);
draw_set_alpha(alpha);
draw_rectangle(-TILE_SIZE,-TILE_SIZE,GAME_W+TILE_SIZE,GAME_H+TILE_SIZE,false);
draw_set_alpha(1);