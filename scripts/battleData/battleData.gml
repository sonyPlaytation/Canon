
global.advantage = 0;

global.actionLibrary = 
{
	// NOTES FOR OPERATION
	// subMenu can be -1 to be a top level action, otherwise it MUST have subMenu
	
	attack:
	{
		name: "Attack",
		type : "attack",
		description: "{0} attacks {1}!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit8,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/4, user.str/4));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	normals:
	{
		name: "Normals",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		//fxSprite : sPunch,
		//effectOnTarget: MODE.ALWAYS,
		//hitSound : snHit8,
		func : function(user, targets)
		{
			with oBattle {state = doNormals;}
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
		frameCost : 33,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit8,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/4, user.str/4));
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
		frameCost : 42,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit7,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/3, user.str/3));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	heavy:
	{
		name: "Fierce",
		type : "attack",
		description: "{0} CLOBBERS {1}!",
		subMenu : "Normals",
		frameCost : 85,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit9,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/2, user.str/2));
			battleChangeHP(targets[0], -damage,, self.hitSound);
		}
	},
	
	special:
	{
		name: "AOE",
		type : "attack",
		description: "{0} uses their special move!",
		subMenu : "Specials",
		exCost : 5,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.ALWAYS,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit6,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.exStr + random_range(-user.exStr/3, user.exStr/2));
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
		userAnimation : "attack",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil((user.exStr*3) + random_range(-user.exStr/3, user.exStr/2));
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
		userAnimation : "attack",
		fxSprite : sHeal,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHealMinor,
		func : function(user, targets)
		{
			var damage = ceil(targets[0].hpMax * 0.66)
			battleChangeHP(targets[0], damage, 1, self.hitSound);
		}
	}
	
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

global.party = 
[
	{
		// BASIC
		name: "Nils",
		job : "Fool",

		// STATS
		lvl : 1,
		EXP : 0,
		hp: 50,
		hpMax: 50,
		ex: 15,
		exMax: 15,
		str: 4,
		exStr: 7,
		
		// BATTLE
		sprites : { idle: sNilsIdle, active: sNilsWalkD, attack: sNilsIdle, defend: sNilsIdle, down: sGrave, head: sHeadNils, portrait: sPortNils},
		actions: [global.actionLibrary.normals]
		
	},

	{
		name: "Charlie",
		job : "Magician",
		
		lvl : 1,
		EXP : 0,
		hp: 40,
		hpMax: 40,
		ex: 20,
		exMax: 20,
		str: 3,
		exStr: 4,
		
		sprites : { idle: sCharIdle, active: sCharFightActive, attack: sCharIdle, defend: sCharIdle, down: sGrave, head: sHeadChar, portrait: sPortNils},
		actions: [global.actionLibrary.normals, global.actionLibrary.special, global.actionLibrary.heal, global.actionLibrary.revive]
	},
	
	{
		name: "Matthew",
		job : "Hermit",
		
		lvl : 1,
		EXP : 0,
		hp: 75,
		hpMax: 75,
		ex: 12,
		exMax: 12,
		str: 5,
		exStr: 6,
		
		sprites : { idle: sMattIdle, active: sMatthewFightActive, attack: sMattIdle, defend: sMattIdle, down: sGrave, head: sHeadMatt, portrait: sPortNils},
		actions: [global.actionLibrary.normals, global.actionLibrary.special]
	}

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
				return (unit.hp <= (unit.hpMax*0.65) and unit.hp > 0);
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
				return unit.hp <= 0;
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
						return (unit.hp > 0);	
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
		hp : 30,
		hpMax: 30,
		ex: 10,
		exMax: 10,
		str: 4,
		exStr: 5,
		sprites : { idle: sSand, attack: sSand, defend: sSand, down: sGrave, head: sSand},
		actions: [global.actionLibrary.medium,global.actionLibrary.heavy,global.actionLibrary.special],
		xpWorth: 15,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(user,targets);
			return [myMove[0],myMove[1]] 
		}
	},
	
	bat:
	{
		name: "Swoopty",
		hp : 1,
		hpMax: 25,
		ex: 15,
		exMax: 15,
		str: 3,
		exStr: 6,
		sprites : { idle: sBat, attack: sBat, defend: sSand, down: sGrave, head: sBat},
		actions: [global.actionLibrary.light,global.actionLibrary.revive],
		xpWorth: 12,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(user,targets);
			return [myMove[0],myMove[1]] 
		}
	}

}