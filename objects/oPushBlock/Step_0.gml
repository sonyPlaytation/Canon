
//if !array_contains(colls, oBlockStopper) {array_push(colls,oBlockStopper)}

var dx = lengthdir_x(spd,dir);
var dy = lengthdir_y(spd,dir);

move_and_collide(dx,dy,colls)

if readyToStop and (x mod TILE_SIZE == 0 and y mod TILE_SIZE == 0)
{
	tilesTravelled++
	instance_destroy(mycoll)
	
	if tilesTravelled == travelTime or place_meeting(x + dx, y + dy, colls)
	{
		spd = 0	
		if x mod TILE_SIZE != 0 {x = round(x/TILE_SIZE) * TILE_SIZE}
		if y mod TILE_SIZE != 0 {y = round(y/TILE_SIZE) * TILE_SIZE}
		//TODO make it perfectly align to the grid ALWAYS!!!!
	}
}