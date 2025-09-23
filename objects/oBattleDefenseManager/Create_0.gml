
event_inherited()

depth = -9999
defender.depth = depth - 10

closestGuide = true

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

stick = instance_create_depth(x,y,depth-50,oBattleDefenseStick)
with stick 
{
	defender = other.defender
	sprite_index = defender.sprites.head
	dist = other.radiusTarg
}

bulletManager = instance_create_depth(x,y,depth-25,oBattleBulletManager, variable_clone(global.patterns[$ enemyMove]));
bulletManager.user = user;

function bulletHit(_bullet, _blocked = false)
{
	var dmg = _bullet.dmg
	if _blocked {dmg *= 0.45;}
	
	bulletManager.cooldownReset += 2
	
	battleChangeHP(defender,ceil(-dmg))
	oBattle.parriesMissed++;
	global.cam.shake_screen(12,5)
	SFX snHit8
}

function parried()
{
	if variable_struct_exists(defender.sprites,"parry") {defender.sprite_index = defender.sprites.parry}
	
	defender.parry = 18.0;
	
	bulletManager.cooldownReset -= 0.25
	
	parry = parryFrames;
	stick.flash = 10;
	stick.parry = 5;
	stick.parryCooldownCurrent = 0;
	stick.currDist = 0;
	InputVerbConsumeAll()
	SFX snParry	
}