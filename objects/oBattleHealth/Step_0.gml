

if !enemy {hp = oBattle.partyHP} else hp = oBattle.enemyHP
hpPercent = (hp/hpMax)

if !introDone
{ w = approach(w,wMax * hpPercent,4) }
else { w = lerp(w,wMax * hpPercent,0.15) }

if hpPercent <= 0.333 {frame = 2}
else if hpPercent > 0.333 and hpPercent < 0.666 {frame = 1}
else frame = 0; 

headFrame += 0.5;
if headFrame > sprite_get_number(sBattleEnemySkull) headFrame = 0;