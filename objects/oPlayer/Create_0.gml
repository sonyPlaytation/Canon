/// @

hsp = 0;
vsp = 0;
walksp = 2;
dir = 0;
onGround = true

tiles = layer_tilemap_get_id("CollTiles");

groundMove = function()
{
	var xinput = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
	var yinput = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
	
	var going = (point_distance(0, 0, xinput, yinput) > 0);
	
	if going 
	{
		dir = point_direction(0, 0, xinput, yinput);
		spd = walksp;
	}
	else
	{
		spd = 0;
	}
	
	hsp = lengthdir_x(spd,dir);
	vsp = lengthdir_y(spd,dir);	
	
	move_and_collide(hsp,vsp,[oColl,tiles]);
}