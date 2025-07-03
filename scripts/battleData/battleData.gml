

global.actionLibrary = 
{
	light:
	{
		name: "Jab",
		description: "LP",
		subMenu : "Normals",
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/4, user.str/4));
			battleChangeHP(targets[0], -damage, 0);
		}
	},
	
	medium:
	{
		name: "Straight",
		description: "MP",
		subMenu : "Normals",
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/3, user.str/3));
			battleChangeHP(targets[0], -damage, 0);
		}
	},
	
	heavy:
	{
		name: "Fierce",
		description: "HP",
		subMenu : "Normals",
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = ceil(user.str + random_range(-user.str/2, user.str/2));
			battleChangeHP(targets[0], -damage);
		}
	},
	
	special:
	{
		name: "Special",
		description: "EX",
		subMenu : "Specials",
		exCost : 5,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = ceil(user.exStr + random_range(-user.exStr/3, user.exStr/2));
			battleChangeHP(targets[0], -damage);
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
		name: "Nils",
		hp: 120,
		hpMax: 120,
		ex: 15,
		exMax: 15,
		str: 4,
		exStr: 7,
		sprites : { idle: sNils, active: sNilsWalkDown, attack: sNils, defend: sNils, down: sGrave, head: sHeadNils},
		actions: [global.actionLibrary.light,global.actionLibrary.medium,global.actionLibrary.heavy, global.actionLibrary.special]
	},

	{
		name: "Charlie",
		hp: 100,
		hpMax: 100,
		ex: 20,
		exMax: 20,
		str: 3,
		exStr: 4,
		sprites : { idle: sCharlie, active: sCharlie, attack: sCharlie, defend: sCharlie, down: sGrave, head: sHeadChar},
		actions: [global.actionLibrary.light,global.actionLibrary.medium,global.actionLibrary.heavy, global.actionLibrary.special]
	},
	
	{
		name: "Matthew",
		hp: 175,
		hpMax: 175,
		ex: 12,
		exMax: 12,
		str: 5,
		exStr: 6,
		sprites : { idle: sMatthew, active: sMatthew, attack: sMatthew, defend: sMatthew, down: sGrave, head: sHeadMatt},
		actions: [global.actionLibrary.light,global.actionLibrary.medium,global.actionLibrary.heavy, global.actionLibrary.special]
	}

]

global.enemies = 
{
	sand:
	{
		name: "Really Angry Sand",
		hp : 50,
		hpMax: 50,
		ex: 10,
		exMax: 10,
		str: 4,
		exStr: 5,
		sprites : { idle: sSand, attack: sSand, defend: sSand, down: sGrave, head: sSand},
		actions: [global.actionLibrary.medium],
		xpWorth: 15,
		AI: function()
		{
			var action = actions[0];
			var possibleTargets = array_filter(oBattle.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);	
			});
			
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action,target];
		}
	},
	
	bat:
	{
		name: "Placeholder Bat Enemy",
		hp : 25,
		hpMax: 25,
		ex: 15,
		exMax: 15,
		str: 3,
		exStr: 6,
		sprites : { idle: sBat, attack: sBat, defend: sSand, down: sGrave, head: sBat},
		actions: [global.actionLibrary.light],
		xpWorth: 12,
		AI: function()
		{
			var action = actions[0];
			var possibleTargets = array_filter(oBattle.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);	
			});
			
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action,target];
		}
	}

}