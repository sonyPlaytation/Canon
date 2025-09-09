/// @


// background
draw_sprite_stretched(battleBG,2,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);
draw_sprite_stretched(battleBG,1,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);
draw_sprite_stretched(battleBG,0,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);

var padding = TILE_SIZE

// battle text
var maxMessages = 2

//draw_sprite_stretched(sTextBox,0, _x + (padding*4), _y + GAME_H - (padding * 3), GAME_W - (padding*8), padding * 3 )

//for (var i = min(array_length(btlText)-1,maxMessages); i >= 0 ; i--)
//{
//	var xx = _x + (padding*4) + (padding/2)
//	var yy = (_y + GAME_H  - (padding * 2.66) + (18*i)) + 8
	
//	var alpha = 1
//	btlText[i].align(fa_left,fa_middle)
//	btlText[i].blend(c_white,alpha)
//	btlText[i].draw(xx, yy)
//	draw_set_alpha(1)
//}

//draw units in depth order
var activeUnit = unitTurnOrder[turn].id
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		event_perform(ev_draw,0)
	}
}

//if sState.get_current_state() == "victory" 
exit;

//right box
draw_sprite_stretched(sTextBox,0, _x + 240, _y + (padding/2), GAME_W - (padding) - 240, padding * 3 )

// column headers
var colEnemy = 15;
var panel_dist = 236;
var colName =	panel_dist;
var colHP =		panel_dist + 90;
var colEX =		panel_dist + 150;

var txtX = _x + padding
var txtY = _y + padding

draw_set_text(fSmart,c_white,fa_left,fa_top);
//draw_text(txtX+colEnemy,	txtY, "ENEMY");
draw_text(txtX+colName,		txtY, "NAME");
draw_text(txtX+colHP,		txtY, "HP");
draw_text(txtX+colEX,		txtY, "EX");

// enemy names
//draw_set_text(fSmall,c_white,fa_left,fa_top);
//var drawLimit = 3;
//var drawn = 0;

//for (var i = 0; i < array_length(enemyUnits) and (drawn < drawLimit); i++)
//{
//	var char = enemyUnits[i];
//	if char.stats.hp > 0
//	{
//		drawn++;
//		draw_set_color(c_white);
//		if char.id == activeUnit {draw_set_color(c_yellow);}
//		draw_text(txtX+colEnemy,txtY + 12 + (12*i), char.name);
//	}
//}

//Hero stats
for (var i = 0; i < array_length(partyUnits); i++)
{
	var char = partyUnits[i];
	if char.stats.hp > 0
	{
		draw_set_color(c_white);
		if char.id == activeUnit {draw_set_color(c_yellow);}
	} else draw_set_color(c_grey);
	
	draw_text(txtX+colName,txtY + 12 + (12*i), char.name);
	draw_set_color(c_white);
	draw_text(txtX+colHP,txtY + 12 + (12*i), $"{char.stats.hp}/{char.stats.hpMax}");
	draw_text(txtX+colEX,txtY + 12 + (12*i), $"{char.stats.ex}/{char.stats.exMax}");
}

if cursor.active 
{
	with cursor	
	{
		if activeTarget != noone
		{
			if !is_array(activeTarget)
			{
				draw_sprite(sMenuArrow,0, activeTarget.x-24, activeTarget.selfCenter)	
			}
			else
			{
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(sMenuArrow,0, activeTarget[i].x-24, activeTarget[i].selfCenter)	;
				}
			}
		}
	}
}

if global.debug
{
	draw_text(_x + (GAME_W/3),_y + (GAME_H/3), normalsTimer)	
	draw_text(_x,_y,stateName)
}

draw_text(_x+100,_y+100,sState.get_current_state())
draw_text(_x+100,_y+120,postParryCounter)