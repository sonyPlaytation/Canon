
global.advantage = 0;
global.lvlCap = 100;

itemFuncs()

global.actionLibrary = 
{
	// NOTES FOR OPERATION
	// subMenu can be -1 to be a top level action, otherwise it MUST have subMenu
	
	normals:
	{
		name: "Normals",
		subMenu : -1,
		type : "attack",
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		//fxSprite : sPunch,
		//effectOnTarget: MODE.ALWAYS,
		//hitSound : snHit8,
		func : function(user, targets)
		{
			with oBattle 
			{
				sState.change("doNormals");
			}
		}
	},
	
	enemyNormals:
	{
		name: "Normals",
		subMenu : -1,
		type : "attack",
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		//fxSprite : sPunch,
		//effectOnTarget: MODE.ALWAYS,
		//hitSound : snHit8,
		func : function(user, targets)
		{
			oBattle.sState.change("enemyNormals");
			oBattle.enemyMove = user.attacks[irandom(array_length(user.attacks)-1)];
		}
	},
	
	attack:
	{
		name: "Attack",
		type : "attack",
		description: "{0} attacks {1}!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit8,
		func : function(user, targets)
		{
			var damage = ceil(user.stats.str + random_range(-user.stats.str/4, user.stats.str/4));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	light:
	{
		name: "Jab",
		type : "attack",
		notation: "LP",
		description: "{0} jabs {1}!",
		subMenu : "Normals",
		targetRequired : true,
		frameCost : 6,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit8,
		func : function(user, targets)
		{
			var damage = ceil(user.stats.str * random_range(1.25,1.5));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	medium:
	{
		name: "Straight",
		type : "attack",
		description: "{0} punches {1}!",
		subMenu : "Normals",
		targetRequired : true,
		frameCost : 8,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit7,
		func : function(user, targets)
		{
			var damage = ceil(user.stats.str * random_range(1.5,1.75));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	heavy:
	{
		name: "Fierce",
		type : "attack",
		description: "{0} CLOBBERS {1}!",
		subMenu : "Normals",
		frameCost : 14,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit9,
		func : function(user, targets)
		{
			var damage = ceil(user.stats.str * random_range(1.75,2));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	special:
	{
		name: "Spinning Kick",
		type : "attack",
		description: "{0} uses their special move!",
		subMenu : "Specials",
		exCost : 5,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.VARIES,
		userAnimation : "specials",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit6,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.stats.exStr + random_range(-user.stats.exStr/3, user.stats.exStr/2));
				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
				battleChangeHP(targets[i], -damage,, self.hitSound);
			}
		}
	},
	
	devilshot:
	{
		name: "Devil's Gun",
		type : "attack",
		description: "{0} fires off the Devil's Gun!",
		subMenu : "Specials",
		exCost : 7,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "shoot",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit6,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.stats.exStr * random_range(1,1.25));
				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
				battleChangeHP(targets[i], -damage,, self.hitSound);
			}
		}
	},
	
	devilvolley:
	{
		name: "Devil Volley",
		type : "attack",
		description: "{0} blasts away!",
		subMenu : "Specials",
		exCost : 12,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.ALWAYS,
		userAnimation : "shoot",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit6,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.stats.exStr * random_range(1,1.25));
				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
				battleChangeHP(targets[i], -damage,, self.hitSound);
			}
		}
	},
	
	heal:
	{
		name: "Heal",
		type : "heal",
		description: "{0} casts heal on {1}!",
		subMenu : "Specials",
		exCost : 4,
		targetRequired : true,
		targetEnemyByDefault: false,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil((user.stats.exStr*3) + random_range(-user.stats.exStr/3, user.stats.exStr/2));
				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
				battleChangeHP(targets[i], damage, 0, self.hitSound);
			}
		}
	},
	
	revive:
	{
		name: "Revive",
		type : "revive",
		description: "{0} revives {1}!",
		subMenu : "Specials",
		exCost : 8,
		targetRequired : true,
		targetEnemyByDefault: false,
		targetAll : MODE.NEVER,
		userAnimation : "normals",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		func : function(user, targets)
		{
			var damage = ceil(targets[0].stats.hpMax * 0.66)
			battleChangeHP(targets[0], damage, 1, self.hitSound);
		}
	}
	
}
	
global.patterns = 
{
	def :
	{
		dmg : 0,
		dirs : [0,1,2,3,4,5,6,7],
		rate : 30,
		dist : 150,
		spd : 2,
		funcPerShot : function() {show_debug_message("def");},
	},
	
	cross :
	{
		dmg : 0,
		dirs : [0,2,4,6],
		rate : 23,
		dist : 115,
		spd : 2.25,
		funcPerShot : function() {show_debug_message("cross");},
	},
	
	plus :
	{
		dmg : 0,
		dirs : [1,3,5,7],
		rate : 23,
		dist : 115,
		spd : 2.25,
		funcPerShot : function() {show_debug_message("plus");},
	},
	
	spiral :
	{
		dmg : 0,
		dirs : [irandom(7)],
		rate : 30,
		dist : 150,
		spd : 2.45,
		funcPerShot : function() { show_debug_message("spiral"); self.dirs[0]++ },
	},
	
	counterspiral :
	{
		dmg : 0,
		dirs : [irandom(7)],
		rate : 30,
		dist : 150,
		spd : 2.45,
		funcPerShot : function() { show_debug_message("counterspiral"); self.dirs[0]-- },
	},
	
	bursts :
	{
		dmg : 0,
		dirs : [irandom(7)],
		rate : 20,
		dist : 150,
		spd : 2.3,
		funcPerShot : function() { show_debug_message("bursts"); if oBattleBulletManager.shotsShot mod 3 == 0 {self.dirs[0] += irandom_range(2,5)} },
	},
}

struct_foreach(global.actionLibrary, function(_key, _val)
{
	if _val[$ "category"] == ITEM_TYPE.CONSUMABLE {_val[$ "subMenu"] = "Items"}
})

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

#macro PARTY global.party

global.characters = 
[
	{
		// BASIC
		name: "Nils",
		job : "Fool",

		// STATS
		stats : 
		{
			lvl : 1,
			EXP : 0,
			requiredEXP : 50,
			hp: 50,
			hpMax: 50,
			ex: 15,
			exMax: 15,
			
			str: 3,
			def: 4,
			exStr: 8,
			exDef: 5,
			int: 0, // intelligence governs the amount of EX you have, and how fast your meter builds
			spd: 5, // speed is turn order and also move timer bonus time
			cha: 0,
			luk: 5
			
		},

		equips : {
			armor : noone,
			weapon : noone,
			gem1 : noone,
			gem2 : noone
		},

		allergies: [FOOD_TAG.SPICY, FOOD_TAG.SWEETS],
		
		// BATTLE
		sprites : 
		{ 
			idle: sNilsIdle, 
			active: sNilsWalkD, 
			slide: sNilsDash, 
			normals: sNilsDash,
			specials : sNilsShoot1,
			shoot : sNilsShoot1,
			defend: sNilsIdle, 
			down: sGrave, 
			head: sHeadNils, 
			portrait: sBattlePort, 
			parry : sNilsParry
		},
		
		actions: [global.actionLibrary.normals, global.actionLibrary.devilshot, global.actionLibrary.devilvolley],
		battleLines : {
			lowHP : "I could really use a hand right now...",
			lowEX : "Runnin' low on ammo, you guys.",
			justHealed : "Okay, that's so much better.",
			justEXed : "More scary evil bullets, comin' right up!",
			justLeveled :
			[
				"I can already feel this thing getting stronger..."nl" That's a good thing, right?",
				"This prophecy business wouldn't be so bad if I were jacked as shit.",
				"Maybe I don't need to hold back as much."nl"Maybe... maybe this power is good for me..."
			],
			winQuotes : 
			[ 
				"I almost had a heart attack!",
				"Think that was the last of 'em.",
				"If we went home right now, would anyone really care? Probably not.",
				"...but my aim is gettin' better!"
			]
		},
		
	},

	{
		name: "Charlie",
		job : "Magician",
		
		stats : 
		{
			lvl : 1,
			EXP : 0,
			requiredEXP : 50,
			hp: 40,
			hpMax: 40,
			ex: 20,
			exMax: 20,
			
			str: 3,
			def: 4,
			exStr: 6,
			exDef: 6,
			int: 4, // intelligence governs the amount of EX you have, and how fast your meter builds
			spd: 3, // speed is turn order and also move timer bonus time
			cha: 0,
			luk: 4
		},
		
		equips : {
			armor : noone,
			weapon : noone,
			gem1 : noone,
			gem2 : noone
		},
		
		allergies: [FOOD_TAG.SHELLFISH],
		
		sprites : { idle: sCharIdle, active: sCharFightActive, normals: sCharIdle, slide: sCharIdle, defend: sCharIdle, down: sGrave, head: sHeadChar, portrait: sBattlePortPH, parry : sCharParry},
		actions: [global.actionLibrary.normals, global.actionLibrary.heal, global.actionLibrary.revive],
		battleLines : {
			lowHP : "I told grandpa I wouldn't cry anymore...",
			lowEX : "Better hope this next spell works!",
			justHealed : "Only a scrape after all!",
			justEXed : "I feel way more magical now :)",
			justLeveled :
			[
				"Hey Matthew, I have a new spell I really wanna try out!"nl"Wait, where are you going?",
				""
			],
			winQuotes : 
			[
				"I wish we could have spared them...",
				"That was fun!",
				"I hope this moment of friendship will bring you many happy memories!",
				"Would you like to meet my friends? Or are you too injured?"
			]
		},
	},
	
	{
		name: "Matthew",
		job : "Hermit",
		
		stats : 
		{
			lvl : 1,
			EXP : 0,
			requiredEXP : 50,
			hp: 75,
			hpMax: 75,
			ex: 12,
			exMax: 12,
			
			str: 4,
			def: 6,
			exStr: 5,
			exDef: 4,
			int: 2, // intelligence governs the amount of EX you have, and how fast your meter builds
			spd: 5, // speed is turn order and also move timer bonus time
			cha: 0,
			luk: 3
		},
		
		equips : {
			armor : noone,
			weapon : noone,
			gem1 : noone,
			gem2 : noone
		},
		
		allergies: [FOOD_TAG.DAIRY],
		
		sprites : { idle: sMattIdle, active: sMatthewFightActive, normals: sMattIdle,  slide: sMattIdle, defend: sMattIdle, down: sGrave, head: sHeadMatt, portrait: sBattlePortPH, parry : sMattParry},
		actions: [global.actionLibrary.normals, global.actionLibrary.special],
		battleLines : {
			lowHP : "[shake]Egh-[/shake] I've had worse... [c_dkgrey]dammit...",
			lowEX : "Man, I have enough of an 'EX' problem as is...",
			justHealed : "I could've toughed it out...",
			justEXed : "Who wants some?",
			justLeveled :
			[
				"Hey man, don't take it personally. It's not easy being this much better than you.",
				"I'm gonna need all the defense I can get if Charlie's gonna keep testing his spells out on me...",
				"OOOOOH I'll givem wunna these! and wunna those! And wunna-"nl"And wunna these, and wunna those! And I'll choke 'em!!"nl"And givem wunna these! and I'll..."
			],
			winQuotes : 
			[
				"Wubba, wubba. I'm in the pink today, boys!",
				"Don't you want a rematch...?",
				"You don't have to be big, to look like a big loser."
			]
		},
	}
]

global.party = 
[
	global.characters[0],
	global.characters[1],
	global.characters[2]
]

// Enemy AI Types
global.enemyAI = 
{
	standard : function(user,targets)
	{
		var actions = oBattle.unitTurnOrder[oBattle.turn].actions;
		var action = actions[irandom(array_length(actions)-1)];
		var actionTypes = []
			
		// figure out what kinds of moves the enemy is capable of
		for (var i = 0; i < array_length(actions); i++)
		{
			if !array_contains(actionTypes,action.type) {array_push(actionTypes, action.type)}
		}
		
		// HEAL
		if array_contains(actionTypes, "heal")
		{
			var toHeal = array_filter(oBattle.enemyUnits, function(unit, index)
			{
				return (unit.stats.hp <= (unit.stats.hpMax*0.65) and unit.stats.hp > 0);
			});
				
			if array_length(toHeal) > 0 {action = global.actionLibrary.heal}
			else 
			{
				var attacks = array_filter(actions,function(action)
				{
					return action.type == "attack";
				});
				action = attacks[irandom(array_length(attacks)-1)];
			}
		}
			
		// REVIVE
		if array_contains(actionTypes, "revive")
		{
			var toRevive = array_filter(oBattle.enemyUnits, function(unit, index)
			{
				return unit.stats.hp <= 0;
			});
				
			if array_length(toRevive) > 0 {action = global.actionLibrary.revive}
			else 
			{
				var attacks = array_filter(actions,function(action)
				{
					return action.type == "attack"
				});
				action = attacks[irandom(array_length(attacks)-1)];
			}
		}
			
		// do action
		switch (action.type)
		{
			case "heal":
			{
				var target = toHeal[irandom(array_length(toHeal)-1)];
				return [action,target];
			}
				
			case "revive":
			{
				var target = toRevive[irandom(array_length(toRevive)-1)];
				return [action,target];
			}
				
			case "attack":
			{

				if action.targetAll = MODE.ALWAYS
				{ targets = oBattle.partyUnits; return [action,targets]; }
				else
				{
					var possibleTargets = array_filter(oBattle.partyUnits, function(unit, index)
					{
						return (unit.stats.hp > 0);	
					});
					
					var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
					return [action,target]
				}
			}
		}	
	}	
}

// Enemies
global.enemies = 
{
	sand:
	{
		name: "Really Angry Sand",
		
		stats : 
		{
			hpMax: 30,
			ex: 10,
			exMax: 10,
			str: 8,
			def : 2,
			exStr: 5,
			spd : 4
		},
		
		sprites : { idle: sSand, normals: sSand, defend: sSand, down: sGrave, head: sSand},
		actions: [global.actionLibrary.enemyNormals],
		attacks: ["bursts","def","cross"],
		xpWorth: 6,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(user,targets);
			return [myMove[0],myMove[1]] 
		}
	},
	
	bat:
	{
		name: "Swoopty",
		stats : 
		{
			hpMax: 25,
			ex: 15,
			exMax: 15,
			str: 6,
			def: 1,
			exStr: 6,
			spd : 4
		},
		
		sprites : { idle: sBat, normals: sBat, defend: sSand, down: sGrave, head: sBat},
		actions: [global.actionLibrary.enemyNormals,global.actionLibrary.revive],
		attacks: ["spiral","counterspiral","plus"],
		xpWorth: 4,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(user,targets);
			return [myMove[0],myMove[1]] 
		}
	}
}

struct_foreach(global.enemies, function(_key, _val)
{
	_val.stats[$ "hp"] = _val.stats[$ "hpMax"]
})