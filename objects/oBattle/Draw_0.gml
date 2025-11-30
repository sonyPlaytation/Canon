/// @
/// 
/// 

// cool looking line that im proably not gonna use
//if instance_exists(currentUser) draw_arrow(x,0,currentUser.x,currentUser.y,5); 
//if is_array(currentTargets) and currentUser.acting 
//{
    //for (var i = 0; i < array_length(currentTargets); i++) {
        //
        //var arrowDir = point_direction(currentUser.x,currentUser.y,currentTargets[i].x,currentTargets[i].y)
        //var arrowDist = point_distance(currentUser.x,currentUser.y,currentTargets[i].x,currentTargets[i].y) * 0.75
        //var arrowX = lengthdir_x(arrowDist,arrowDir)
        //var arrowY = lengthdir_y(arrowDist,arrowDir)
        //
        //draw_arrow(currentUser.x,currentUser.y,currentUser.x+arrowX,currentUser.y+arrowY,5); 
    //}    
//}


var padding = TILE_SIZE

draw_set_alpha(textAlpha)
// battle text
var maxMessages = 2
draw_sprite_stretched(sTextBox,0, padding*6, GAME_H - (padding * 3), GAME_W - (padding*12), padding * 3 )
for (var i = min(array_length(btlText)-1,maxMessages); i >= 0 ; i--)
{
    var xx = (padding*6) + (padding/2)
    var yy = (GAME_H  - (padding * 2.66) + (18*i)) + 8
    
    var alpha = 1
    btlText[i].align(fa_left,fa_middle)
    btlText[i].blend(c_white,alpha*textAlpha)
    btlText[i].draw(xx, yy)
    draw_set_alpha(1)
}
draw_set_alpha(1)

draw_sprite(sBattleTurnCount,0, room_width/2, 26);
draw_set_text(global.fSF3Time,c_white,fa_center,fa_middle);
draw_text( room_width/2, 52, roundCount )

//draw units in depth order
var activeUnit = unitTurnOrder[turn].id
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		event_perform(ev_draw,0)
	}
}

//draw_text(x,y,"PENIS")

if sState.get_current_state() == "victory" {exit;}

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
	draw_text(GAME_W/3,GAME_H/3, normalsTimer)	
	
}


//draw_text(_x +100,_y +100,enemyMove)