/// @




// background
draw_sprite(battleBG,0,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2));

//draw units in depth order
var activeUnit = unitTurnOrder[turn].id
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		event_perform(ev_draw,0)
	}
}

//big box
var padding = TILE_SIZE
// left box
draw_sprite_stretched(sTextBox,0, _x + padding, _y + (padding/2), 200, padding * 4 )
//right box
draw_sprite_stretched(sTextBox,0, _x + 240, _y + (padding/2), GAME_W - (padding) - 240, padding * 4 )

// column headers
var colEnemy = 15;
var panel_dist = 236;
var colName =	panel_dist;
var colHP =		panel_dist + 90;
var colEX =		panel_dist + 150;

var txtX = _x + padding
var txtY = _y + padding

draw_set_text(fSmart,c_white,fa_left,fa_top);
draw_text(txtX+colEnemy,	txtY, "ENEMY");
draw_text(txtX+colName,		txtY, "NAME");
draw_text(txtX+colHP,		txtY, "HP");
draw_text(txtX+colEX,		txtY, "EX");

// enemy names
draw_set_text(fSmall,c_white,fa_left,fa_top);
var drawLimit = 3;
var drawn = 0;

for (var i = 0; i < array_length(enemyUnits) and (drawn < drawLimit); i++)
{
	var char = enemyUnits[i];
	if char.hp > 0
	{
		drawn++;
		draw_set_color(c_white);
		if char.id == activeUnit {draw_set_color(c_yellow);}
		draw_text(txtX+colEnemy,txtY + 12 + (12*i), char.name);
	}
}

//Hero stats
for (var i = 0; i < array_length(partyUnits); i++)
{
	var char = partyUnits[i];
	if char.hp > 0
	{
		draw_set_color(c_white);
		if char.id == activeUnit {draw_set_color(c_yellow);}
	} else draw_set_color(c_grey);
	
	draw_text(txtX+colName,txtY + 12 + (12*i), char.name);
	draw_set_color(c_white);
	draw_text(txtX+colHP,txtY + 12 + (12*i), $"{char.hp}/{char.hpMax}");
	draw_text(txtX+colEX,txtY + 12 + (12*i), $"{char.ex}/{char.exMax}");
}

draw_text(currentUser.x,currentUser.y,currentUser.x)
draw_text(currentUser.x,currentUser.y+24,currentUser.xstart)

draw_text(currentUser.x,currentUser.y+48,abs(ceil(point_distance(currentUser.xstart,y, currentUser.x,y ))))