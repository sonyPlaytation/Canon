
draw_self()

draw_set_text(fStout,c_black,fa_center,fa_middle)

if !enemy
{
	
	//for (var i = 0; i < array_length(turnOrder); ++i) 
	//{
	//	if i > 0 {draw_set_color(#3E2551)}
	//	draw_text(_x+65 + (nameXoffset*i), _y+29, turnOrder[i].name) 	    
	//}
	
	//draw_sprite(oBattle.currentUser.sprites.head,0,headx,heady)
	
	if hp > 0 draw_sprite_stretched(sBattleHealthValue,frame,hpx + min(wMax-w,240),hpy,max(w,10),sprite_get_height(sBattleHealthValue))
}
else
{
	draw_set_color(#3E2551)
	draw_text(_x+209, _y+29, "ENEMY") 	    
	
	draw_sprite(sBattleEnemySkull,headFrame,headx,heady)
	
	if hp > 0 draw_sprite_stretched(sBattleHealthValue,frame,hpx,hpy,max(w,10),sprite_get_height(sBattleHealthValue))
}
