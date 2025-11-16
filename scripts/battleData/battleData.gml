
global.advantage = 0;
global.lvlCap = 100;

itemFuncs()

#macro s1 "[sInputArrows, 5]"
#macro s2 "[sInputArrows, 6]"
#macro s3 "[sInputArrows, 7]"
#macro s4 "[sInputArrows, 4]"
#macro s5 "[sInputArrows, 8]"
#macro s6 "[sInputArrows, 0]"
#macro s7 "[sInputArrows, 3]"
#macro s8 "[sInputArrows, 2]"
#macro s9 "[sInputArrows, 1]"

#macro sG "[sInputG, 1]"
#macro sL "[sInputL, 1]"
#macro sM "[sInputM, 1]"
#macro sH "[sInputH, 1]"


global.moves =
{
	superart1 : ["236236L", "236L236L"],
	superart2 : ["236236M", "236M236M"],
	superart3 : ["236236H", "236H236H"],
	
	halfCircle : ["41236L","41236M","41236H"],
	fireball : ["236L","236M","236H"],
	
	uppercut : ["623L","623M","623H"],
	
	normal : ["L","M","H"],
}

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
		userAnimation : "idle",
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
	
	light:
	{
		name: "Jab",
		type : "attack",
		notation: "L",
		description: "{0} jabs {1}!",
		subMenu : -2,
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
			battleChangeEX(user,1)
		}
	},
	
	medium:
	{
		name: "Straight",
		type : "attack",
		notation: "M",
		description: "{0} punches {1}!",
		subMenu : -2,
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
			battleChangeEX(user,2)
		}
	},
	
	heavy:
	{
		name: "Fierce",
		type : "attack",
		notation: "H",
		description: "{0} CLOBBERS {1}!",
		subMenu : -2,
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
			battleChangeEX(user,3)
		}
	},
	
	uppercut:
	{
		name: "Rising Upper",
		type : "attack",
		notation : global.moves.uppercut[2],
		frameCost : 24,
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
		info : {
			desc : "Deal fire damage to one"nl"enemy. Can hit multiple targets.",
			types : "Fire, Physical",
			input : s6+ s2 + s3 + sH
		},
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
		notation : global.moves.fireball,
		frameCost : 24,
		description: "{0} fires off the Devil's Gun!",
		subMenu : "Specials",
		exCost : 7,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.NEVER,
		userAnimation : "shoot",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit9,
		info : {
			desc : "Shoot a big shot.",
			types : "[sLaughingCryingEmoji] [sLaughingCryingEmoji] [sLaughingCryingEmoji]",
			input : s2+s3+s6+sL
		},
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.stats.exStr * random_range(1.45,2.25));
				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
				battleChangeHP(targets[i], -damage,, self.hitSound);
			}
		}
	},
	
	devilvolley:
	{
		name: "Devil Volley",
		type : "attack",
		notation : global.moves.halfCircle,
		frameCost : 45,
		description: "{0} blasts away!",
		subMenu : "Specials",
		exCost : 12,
		targetRequired : true,
		targetEnemyByDefault: true,
		targetAll : MODE.ALWAYS,
		userAnimation : "volley",
		fxSprite : sPunch,
		effectOnTarget: MODE.ALWAYS,
		hitSound : snHit6,
		info : {
			desc : "Somehow hit everyone"nl"with one bullet.",
			types : "plenis",
			input : s4+s1+s2+s3+s6+sL
        },
		func : function(user, targets)
		{
			for (var i = 0; i< array_length(targets); i++)
			{
				var damage = ceil(user.stats.exStr * random_range(1.25,1.65));
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
	
struct_foreach(global.actionLibrary,function(moveName, move)
{
    if variable_struct_exists(move, "info")
    {
       variable_struct_set(move[$ "info"],"exCost", move[$ "exCost"]) ;
    }
})

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


function initCharacters()
{
	global.characters = 
	[
		{
			// BASIC
			name: global.playerName,
			job : "Fool",

			// STATS
			stats : 
			{
				lvl : 1,
				EXP : 0,
				requiredEXP : 100,
				hp: 50,
				hpMax: 50,
				ex: 50,
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
				idle: sNilsBattleIdle, 
				active: sNilsWalkD, 
				slide: sNilsDash, 
				normals: sNilsBattlePunchL,
				shoot : sNilsBattleShot,
				volley : sNilsBattleVolley,
				defend: sNilsIdle, 
				down: sGrave, 
				head: sHeadNils, 
				portrait: sBattlePort, 
				parry : sNilsBattleParry
			},
		
			actions: [global.actionLibrary.normals, global.actionLibrary.light, global.actionLibrary.medium, global.actionLibrary.heavy, global.actionLibrary.devilshot, global.actionLibrary.devilvolley],
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
				requiredEXP : 100,
				hp: 40,
				hpMax: 40,
				ex: 0,
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
				requiredEXP : 100,
				hp: 75,
				hpMax: 75,
				ex: 0,
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
			actions: [global.actionLibrary.normals, global.actionLibrary.uppercut],
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
		global.characters[0]
	]

}
//FLAGS
