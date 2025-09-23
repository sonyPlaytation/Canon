
partyHP = 0;
array_foreach(partyUnits,function(element,index)
{
	partyHP += partyUnits[index].stats.hp
})
partyHPPercent = partyHP/partyHPMAX

enemyHP = 0;
array_foreach(enemyUnits,function(element,index)
{
	enemyHP += enemyUnits[index].stats.hp
})
enemyHPPercent = enemyHP/enemyHPMAX