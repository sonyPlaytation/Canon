function startFight()
{
	global.cam.set_paused(true)
	instance_create_depth(global.cam.x,global.cam.y,-999,oBattle,
	{
		enemies		: global.fightEnemies,
		creator		: global.fightStarter,
		battleBG	: global.fightBG
	
	})	
};

function leaveBattle()
{
	instance_activate_all();
	global.pauseEvery = false;
	instance_destroy(global.fightStarter);
	instance_destroy(oBattle);	
	instance_destroy(oResultsScreen);	
	oPlayer.iFrames = 90;
	
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	
	layer_sequence_create("transition",global.cam.x,global.cam.y,sqFadeIn);
	
	//oCamera.drawNothing = false
};

function battleChangeHP(target, amount, AliveDeadOrEither = 0, sound = -1)
{
	// ADOE : 
	// 0 - ALIVE, 
	// 1 - DEAD, 
	// 2 - EITHER 	
	var failed = false;
	if (AliveDeadOrEither == 0) and target.hp <= 0 {failed = true};
	if (AliveDeadOrEither == 1) and target.hp > 0 {failed = true};
	text = abs(amount);
	
	var col = c_white;
	if amount > 0 col = c_lime;
	if failed
	{
		if amount < 0 {audio_play_sound(snSwingMiss,765,false)};
		col = c_white;
		text = "Failed!";
		
	}
	else if !failed and sound != -1
	{ 
		if amount > 0 //healing
		{
			if target.hp <= 0 {text = "Resurrection!";}
			target.flashCol = c_white
			target.flash += 15;
		}
		else
		{
			target.flash = 0;
			target.flashCol = c_red
			target.flash += 5;
			global.cam.shake_screen(amount/2,abs(amount))	
		}
		
		oSFX.battlehit = sound; 
	}
	
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
	if is_numeric(amount) and !failed {target.hp = clamp(target.hp + amount, 0, target.hpMax)};
}


function battleChangeEX(target, amount, sound = -1)
{
	// ADOE : 0 - ALIVE, 1 - DEAD, 2 - EITHER 	
	// Failure is going to be kind of an edge case
	// I imagine it only really happening if an EX move is queued up 
	// and someone steals or somehow lowers your EX
	var failed = false;
	
	var col = c_white;
	if amount > 0 col = c_lime;
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
	if !failed {target.hp = clamp(target.hp + amount, 0, target.hpMax)};
}
