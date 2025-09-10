/// @


// background
draw_sprite_stretched(battleBG,2,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);
draw_sprite_stretched(battleBG,1,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);
draw_sprite_stretched(battleBG,0,global.cam.x - (GAME_W/2),global.cam.y - (GAME_H/2),GAME_W,GAME_H);

var padding = TILE_SIZE

// battle text
var maxMessages = 2

draw_sprite_stretched(sTextBox,0, _x + (padding*4), _y + GAME_H - (padding * 3), GAME_W - (padding*8), padding * 3 )

for (var i = min(array_length(btlText)-1,maxMessages); i >= 0 ; i--)
{
	var xx = _x + (padding*4) + (padding/2)
	var yy = (_y + GAME_H  - (padding * 2.66) + (18*i)) + 8
	
	var alpha = 1
	btlText[i].align(fa_left,fa_middle)
	btlText[i].blend(c_white,alpha)
	btlText[i].draw(xx, yy)
	draw_set_alpha(1)
}

//draw units in depth order
var activeUnit = unitTurnOrder[turn].id
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		event_perform(ev_draw,0)
	}
}

if sState.get_current_state() == "victory" 
exit;

// the cursor
if cursor.active 
{
	with cursor	
	{
		if activeTarget != noone
		{
			if !is_array(activeTarget)
			{
				var frame = 0
				if targetSide == oBattle.partyUnits {frame = 2}
				
				draw_sprite(sMenuArrow,frame, activeTarget.x+(24*activeTarget.image_xscale), round(activeTarget.selfCenter))	
			}
			else
			{
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					var frame = 0
					if targetSide == oBattle.partyUnits {frame = 2}
					
					draw_sprite(sMenuArrow,frame, activeTarget[i].x+(24*sign(activeTarget[i].image_xscale)), round(activeTarget[i].selfCenter));
				}
			}
		}
	}
}

if global.debug
{
	draw_text(_x + (GAME_W/3),_y + (GAME_H/3), normalsTimer)	
	draw_text(100,100,sState.get_current_state())
}
