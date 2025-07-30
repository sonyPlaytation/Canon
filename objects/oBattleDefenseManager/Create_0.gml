
event_inherited()

depth = -9999
defender.depth = depth - 10

midX = global.cam.x
midY = global.cam.y

alpha = 0;
alphaTarg = 0.7;
color = c_black

parry = 0;
parryFrames = 10;

lerpSpeed = 0.15;

radius = 0
prevRadius = radius;
radiusTarg = TILE_SIZE;
hitBoxSize = radiusTarg - 8

global.cam.follow = id

stick = instance_create_depth(x,y,depth-50,oBattleDefenseStick)
with stick 
{
	defender = other.defender
	sprite_index = defender.sprites.head
	dist = other.radiusTarg
}

bulletManager = instance_create_depth(x,y,depth-25,oBattleBulletManager)

function bulletHit(_bullet, _blocked = false)
{
	var dmg = _bullet.dmg
	if _blocked {dmg *= 0.45;}
	
	battleChangeHP(defender,ceil(-dmg))
	global.cam.shake_screen(12,5)
	SFX snHit8
}

function parried()
{
	parry = parryFrames;
	stick.flash = 5;
	SFX snParry	
}