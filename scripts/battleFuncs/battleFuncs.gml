function startFight()
{
	instance_create_depth(global.cam.x,global.cam.y,-999,oBattle,
	{
		enemies		: global.fightEnemies,
		creator		: global.fightStarter,
		battleBG	: global.fightBG
	
	})	
};

function battleChangeHP(target, amount, AliveDeadOrEither = 0)
{
	// ADOE : 0 - ALIVE, 1 - DEAD, 2 - EITHER 	
	var failed = false;
	if (AliveDeadOrEither == 0) and target.hp <= 0 {failed = true};
	if (AliveDeadOrEither == 1) and target.hp > 0 {failed = true};
	
	var col = c_white;
	if amount > 0 col = c_lime;
	if failed
	{
		col = c_white;
		amount = "Failed!";
	}
	instance_create_depth
	(
		target.x,
		target.selfCenter,
		target.depth-20,
		oBattleFloatingText,
		{
			font : fSmall,
			color : col,
			text : string(amount)
		}
	)
	if !failed {target.hp = clamp(target.hp + amount, 0, target.hpMax)};
}