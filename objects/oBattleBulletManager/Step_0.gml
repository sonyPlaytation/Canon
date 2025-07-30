

if cooldown > 0 {cooldown--}

if cooldown <= 0 and !pleaseWrapItUp
{
	var bX, bY
	
	dir = irandom(7) * 45
	
	bX = lengthdir_x(dist,dir)
	bY = lengthdir_y(dist,dir)
	
	instance_create_depth(x + bX, y+ bY,depth-100,oBulletTest,
	{
	
		dir : dir-180,
		spd : spd,
		dmg : dmg
	
	})
	
	cooldown = cooldownReset
	
}