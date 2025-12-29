/// @

drawCharacter()
drawStatus()

if global.debug  {
    
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	draw_text(x,y+5,$"{stats.hp}/{stats.hpMax}")	
	draw_set_text(fSmall,c_white,fa_center,fa_middle)
	draw_text(x,y+25,image_index)	
}

if stats.hp > 0 draw_healthbar(x-18,y+8,x+18,y+9,(stats.hp/stats.hpMax)*100,c_black,c_red,c_lime,0,true,false)