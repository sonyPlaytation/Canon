global.fightStarter = noone

function startFight(_enemies = global.fightEnemies, _creator = global.fightStarter, _battleBG = global.fightBG)
{
	room_goto(rBattle)
	layer_sequence_destroy(self.elementID);
	createTransition(global.typeIn); 
};

function leaveBattle()
{
	instance_activate_all();
	global.pauseEvery = false;
	
	oInputReader.alphaTarg = 1
	end_temp_song()
	
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	
	if (instance_exists(oBattle) and oBattle.sState.get_current_state() == "defeat") {loadGame(true)}
	else {layer_sequence_create("transition",global.cam.x,global.cam.y,sqFadeIn);}
	
	if instance_exists(oBattle) { instance_destroy(oBattle); }
	if instance_exists(oBattleResults) { instance_destroy(oBattleResults); }
	
	room_goto(global.roomTarget)
	
	//oCamera.drawNothing = false
};

function battleChangeHP(target, amount, AliveDeadOrEither = 0, sound = -1)
{
	// ADOE : 
	// 0 - ALIVE, 
	// 1 - DEAD, 
	// 2 - EITHER 	
	var failed = false;
	if (AliveDeadOrEither == 0) and target.stats.hp <= 0 {failed = true};
	if (AliveDeadOrEither == 1) and target.stats.hp > 0 {failed = true};
	text = abs(amount);
	
	var col = c_white;
	if amount > 0 col = c_lime;
	if failed
	{
		if amount < 0 {SFX snSwingMiss};
		col = c_white;
		text = "Whiff!";
		
	}
	else if !failed
	{ 
		if amount > 0 //healing
		{
			if target.stats.hp <= 0 {text = "Resurrection!";}
			target.flash += 15;
		}
		else // damage
		{
			target.hit = 0;
			target.hit += 5;
			amount = min(amount + target.stats.def, 0)
			text = amount;
			global.cam.shake_screen(amount/2,abs(amount))	
		}
		
		if sound != -1 { oSFX.battlehit = sound; } 
	}
	
	var healthLine = -1
	
	if variable_struct_exists(target,"battleLines") 
	{
		if (target.stats.hp > target.stats.hpMax/2) and (target.stats.hp + amount <= target.stats.hpMax/2)	healthLine = target.battleLines.lowHP
		if (amount > 0 and target.stats.hp < target.stats.hpMax) healthLine = target.battleLines.justHealed
	}
	
	if healthLine != -1 {BATTLE($"[{sprite_get_name(target.sprites.head)}]: "+healthLine)}
	
	instance_create_depth
	(
		target.x,
		target.selfCenter,
		target.depth-20,
		oBattleHitText,
		{
			font : fSmall,
			color : col,
			text : text
		}
	)
	if is_numeric(amount) and !failed {target.stats.hp = clamp(target.stats.hp + amount, 0, target.stats.hpMax)};
}

function overworldChangeHP(target, amount, AliveDeadOrEither = 0, sound = -1)
{
	// ADOE : 
	// 0 - ALIVE, 
	// 1 - DEAD, 
	// 2 - EITHER 	
	text = abs(amount);
	
	var col = c_white;
	
	if sound != -1 { SFX sound; } 
	
	var healthLine = -1
	
	instance_create_depth
	(
		target.x,
		target.selfCenter,
		target.depth-20,
		oBattleHitText,
		{
			font : fSmall,
			color : col,
			text : text
		}
	)
	if is_numeric(amount) {target.stats.hp = clamp(target.stats.hp + amount, 0, target.stats.hpMax)};
}


function battleChangeEX(target, amount, _number = false, sound = -1)
{
	// ADOE : 0 - ALIVE, 1 - DEAD, 2 - EITHER 	
	// Failure is going to be kind of an edge case
	// I imagine it only really happening if an EX move is queued up 
	// and someone steals or somehow lowers your EX
	var failed = false;
	
	var col = c_white;
	if amount > 0 
    {
        col = c_aqua;
        //amount *= ceil(user.stats.int/100)
    }
    
	if failed
	{
		if amount < 0 {audio_play_sound(snSwingMiss,765,false)};
		col = c_white;
		amount = "Failed!";
		
	}
	else if !failed
	{
		if ! audio_is_playing(sound) {audio_play_sound(sound,765,false);}
	}
	
	if _number
	{
		instance_create_depth
		(
			target.x,
			target.selfCenter,
			target.depth-20,
			oBattleHitText,
			{
				font : fSmall,
				color : col,
				text : string(amount)
			}
		)
	}
	
	if !failed {target.stats.ex = clamp(target.stats.ex + amount, 0, target.stats.exMax)};
}

