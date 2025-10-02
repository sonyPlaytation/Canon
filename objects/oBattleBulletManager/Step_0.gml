
upTime++;

if instance_exists (oBattleDefenseManager)
{
	if oBattleDefenseManager.parry > 0 {exit}
}

if currentCooldown > 0 {currentCooldown--}

if currentCooldown <= 0 and !pleaseWrapItUp
{
	var bX, bY
	
	shotDir = dirs[irandom(array_length(dirs)-1)]*45;
	
	bX = lengthdir_x(dist,shotDir)
	bY = lengthdir_y(dist,shotDir)
	
	instance_create_depth(x + bX, y+ bY,depth-100,oBullet,
	{
		dir : shotDir-180,
		spd : spd,
		dmg : user.stats.str + dmg
	})
	
	shotsShot++;
	funcPerShot();
	
	currentCooldown = ceil(cooldownReset)
	
}