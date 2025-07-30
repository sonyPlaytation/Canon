
if !pleaseWrapItUp
{
	var bullsHitting = ds_list_create() //short for "Bullets Hitting Me"

	if collision_circle_list(x,y,hitBoxSize,pEnemyAttack,false,false,bullsHitting,true)
	{
		var bullet = ds_list_find_value(bullsHitting,0)
	
		if place_meeting(bullet.x,bullet.y,oBattleDefenseHitbox)
		{
			bulletHit(bullet, true)
			oBattleDefenseHitbox.image_alpha = 3
		}
		else
		{
			if stick.parryTimer > 0
			{
				stick.bullet = bullet
	
				with stick
				{
					if place_meeting(x,y,bullet)
					{
						other.parried()
					} else other.bulletHit(bullet)
				}
			}
			else bulletHit(bullet)
		}
	
		instance_destroy(bullet)	
	}

	ds_list_destroy(bullsHitting);
}