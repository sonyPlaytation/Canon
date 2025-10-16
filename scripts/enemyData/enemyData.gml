


global.patterns = 
{
	def :
	{
        obj : oBullet,
		dmg : 0,
		dirs : [0,1,2,3,4,5,6,7],
		rate : 30,
		dist : 150,
		spd : 2.5,
	},
	
	cross :
	{
        obj : oBullet,
		dmg : 0,
		dirs : [0,2,4,6],
		rate : 23,
		dist : 115,
		spd : 2.25,
	},
	
	plus :
	{
        obj : oBullet,
		dmg : 0,
		dirs : [1,3,5,7],
		rate : 23,
		dist : 115,
		spd : 2.25,
	},
	
	spiral :
	{
        obj : oBulletBats,
		dmg : 0,
		dirs : [],
		rate : 35,
		dist : 100,
		spd : 3,
		funcPerShot : function() { self.dirs[0] += oBattleBulletManager.dir; },
        createFunc : function(){dirs[0] = irandom(7); dir = choose(1,-1)}
	},
	
	bursts :
	{
        obj : oBullet,
		dmg : 0,
		dirs : [irandom(7)],
		rate : 20,
		dist : 150,
		spd : 2.4,
		funcPerShot : function() { if oBattleBulletManager.shotsShot mod 3 == 0 {self.dirs[0] += irandom_range(2,5)} },
	},
	
	ant :
	{
        obj : oBullet,
		dmg : 1,
		dirs : [0,1,2,3,4,5,6,7],
		rate : 20,
		dist : 150,
		spd : 5,
		funcPerShot : function() { oBattle.normalsTimer -= 10},
	},
	
	antDaigo :
	{
        obj : oBullet,
		dmg : 1,
		dirs : [],
		rate : 11,
		dist : 100,
		spd : 4,
        createFunc : function(){dirs[0] = choose(0,4);}
	},
}

struct_foreach(global.patterns, function(_key, _val)
{
	if _val[$ "funcPerShot"] == undefined { _val.funcPerShot = function(){} }
	if _val[$ "createFunc"] == undefined { _val.createFunc = function(){} }
})


// Enemy AI Types
global.enemyAI = 
{
	standard : function(user,targets)
	{
		var actions = user.actions;
		var action = actions[irandom(array_length(actions)-1)];
		var actionTypes = []
			
		// figure out what kinds of moves the enemy is capable of
		for (var i = 0; i < array_length(actions); i++){
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
                randomize();
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
			str: 14,
			def : 2,
			exStr: 5,
			spd : 4
		},
		
		sprites : { idle: sSand, normals: sSand, defend: sSand, down: sGrave, head: sSand},
		actions: [global.actionLibrary.enemyNormals],
		attacks: ["bursts","def"],
		xpWorth: 6,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(self,targets);
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
			str: 12,
			def: 1,
			exStr: 6,
			spd : 4
		},
		
		sprites : { idle: sBat, normals: sBat, defend: sSand, down: sGrave, head: sBat},
		actions: [global.actionLibrary.enemyNormals,global.actionLibrary.revive],
		attacks: ["spiral"],
		xpWorth: 4,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(self,targets);
			return [myMove[0],myMove[1]] 
		}
	},
	
	ant:
	{
		name: "Feral Ant",
		stats : 
		{
			hpMax: 15,
			ex: 15,
			exMax: 15,
			str: 15,
			def: 0,
			exStr: 6,
			spd : 6
		},
		
		sprites : { idle: sFeralAnt, normals: sFeralAnt, defend: sFeralAnt, down: sGrave, head: sFeralAnt},
		actions: [global.actionLibrary.enemyNormals],
		attacks: ["antDaigo", "ant"],
		xpWorth: 4,
		AI: function(user,targets)
		{
			var myMove = global.enemyAI.standard(user,targets);
			return [myMove[0],myMove[1]] 
		}
	},
        
    cactus:
	{
		name: "Okey-Pokey",
		stats : 
		{
			hpMax: 35,
			ex: 15,
			exMax: 15,
			str: 13,
			def: 1,
			exStr: 6,
			spd : 4
		},
		
		sprites : { idle: sOkeyPokey, normals: sOkeyPokey, defend: sOkeyPokey, down: sGrave, head: sOkeyPokey},
		actions: [global.actionLibrary.enemyNormals],
		attacks: ["plus","cross","cross"],
		xpWorth: 7,
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