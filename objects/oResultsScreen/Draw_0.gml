/// @

draw_set_color(#230F33)
draw_set_alpha(alpha)
draw_rectangle_color(global.cam.x-GAME_W,global.cam.y-GAME_H,global.cam.x+GAME_W,global.cam.y+GAME_H,#230F33,#230F33,#17002B,#17002B,false)
draw_set_alpha(1)
draw_set_color(c_white)

if alpha >= alphaTarg*0.9
{
	draw_sprite_stretched(sTextBox,1,_x,_y,w,h)
}

if h == targH
{
	draw_sprite_stretched(sTextBox, 0, textX, _y + padding, 100, 100)
	draw_sprite_stretched(sTextBox, 0, textX+150, _y + padding, 100, 100)
	draw_sprite_stretched(sTextBox, 0, textX+300, _y + padding, 100, 100)
	
	draw_set_text(fSmall,c_white,fa_left,fa_top)
	
	draw_text(textX+padding, _y + (padding)   + 120, string(global.party[0].name)	)
	draw_text(textX+padding, _y + (padding*2)   + 120, string(global.party[0].job)	)
	draw_text(textX+padding, _y + (padding*3) + 120, "lvl "+string(global.party[0].lvl)		)
	draw_text(textX+padding, _y + (padding*4) + 120, "EXP "+string(global.party[0].EXP)		)
	draw_text(textX+padding, _y + (padding*5) + 120, "hpMax "+string(global.party[0].hpMax)	)
	draw_text(textX+padding, _y + (padding*6) + 120, "exMax "+string(global.party[0].exMax)	)
	draw_text(textX+padding, _y + (padding*7) + 120, "str "+string(global.party[0].str)		)
	draw_text(textX+padding, _y + (padding*8) + 120, "exStr "+string(global.party[0].exStr)	)
	
	draw_text(textX+padding+150, _y + (padding)   + 120, string(global.party	[1].name)	)
	draw_text(textX+padding+150, _y + (padding*2)   + 120, string(global.party	[1].job)	)
	draw_text(textX+padding+150, _y + (padding*3) + 120, "lvl "+string(global.party		[1].lvl)		)
	draw_text(textX+padding+150, _y + (padding*4) + 120, "EXP "+string(global.party		[1].EXP)		)
	draw_text(textX+padding+150, _y + (padding*5) + 120, "hpMax "+string(global.party	[1].hpMax)	)
	draw_text(textX+padding+150, _y + (padding*6) + 120, "exMax "+string(global.party	[1].exMax)	)
	draw_text(textX+padding+150, _y + (padding*7) + 120, "str "+string(global.party		[1].str)		)
	draw_text(textX+padding+150, _y + (padding*8) + 120, "exStr "+string(global.party	[1].exStr)	)
	
	draw_text(textX+padding+300, _y + (padding)   + 120,string(global.party	[2].name)	)
	draw_text(textX+padding+300, _y + (padding*2)   + 120, string(global.party	[2].job)	)
	draw_text(textX+padding+300, _y + (padding*3) + 120, "lvl "+string(global.party		[2].lvl)		)
	draw_text(textX+padding+300, _y + (padding*4) + 120, "EXP "+string(global.party		[2].EXP)		)
	draw_text(textX+padding+300, _y + (padding*5) + 120, "hpMax "+string(global.party	[2].hpMax)	)
	draw_text(textX+padding+300, _y + (padding*6) + 120, "exMax "+string(global.party	[2].exMax)	)
	draw_text(textX+padding+300, _y + (padding*7) + 120, "str "+string(global.party		[2].str)		)
	draw_text(textX+padding+300, _y + (padding*8) + 120, "exStr "+string(global.party	[2].exStr)	)
	
	draw_sprite(sHeadNils,0,textX+50, _y + padding+50)
	draw_sprite(sHeadChar,0,textX+200, _y + padding+50)
	draw_sprite(sHeadMatt,0,textX+350, _y + padding+50)
}