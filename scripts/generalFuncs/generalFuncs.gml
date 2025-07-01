function playerSetup(){
	hsp = 0;
	vsp = 0;
	walksp = 2;
	runsp = 3;
	dir = 0;
	onGround = true;
	tiles = layer_tilemap_get_id("CollTiles");
}