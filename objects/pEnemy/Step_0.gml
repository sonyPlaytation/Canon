/// @


if !array_contains(enemies, undefined) and collision_circle(x,y,sprite_width*0.45,oPlayer, false, false)
{
	global.fightStarter = id;
	global.fightEnemies = enemies;
	global.fightBG = bg;
	transition(room,sqFightOut,sqFightIn,true)
	oPlayer.hasControl = false;
}