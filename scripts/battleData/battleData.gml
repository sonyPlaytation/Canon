

initFlags();

#region battle definitions

    #region macros and enums
    
        enum MODE
        {
            NEVER = 0,
            ALWAYS = 1,
            VARIES = 2
        }
        
        enum MOVE_TYPE{
            PHYS,
            STUN,
            FIRE,
            ICE,
            DARK,
            LIGHT,
            ELEC,
            HEAL,
            REVIVE,
            BLOOD,
            BILE,
            PALE,
            PHLEGM,
            SLEEP,
            RADS,
            WORM,
            ENTROPY,
            DEVIL
        }
        
        enum CHAR
        {
        	Nils,
        	Charlie,
        	Matthew
        }
        
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

        #macro PARTY global.party
		#macro NILS global.characters[$ "Nils"]
		#macro CHARLIE global.characters[$ "Charlie"]
		#macro MATTHEW global.characters[$ "Matthew"]
        advantage = 0;
        lvlCap = 99;
        areaLevel = 1;
		characters = {}

        moves =
	    {
	    	superart : [
                "236236L", 
                "236236M", 
                "236236H"],
	    	halfCircle : [
                "41236L",
                "41236M",
                "41236H"],
	    	fireball : [
                "236L",
                "236M",
                "236H"],
	    	dp : [
                "623L",
                "623M",
                "623H"],
	    	
	    	normal : ["L","M","H"],
	    }
    
    #endregion

	#region attacks

		///@param {string} Name 
		///@param {string} Type Move type used for Enemy AI decision-making 
		function Attack(_name = "", _type = "attack") : IMenuable() constructor {
			
			name = _name;
			atkType = _type;
			
			notation = noone; //global.moves 
			submenu = -2;
			exCost = undefined;
			frameCost = undefined;
			atkTypes = [];
			
			targetRequired = true;
			targetEnemyByDefault = true;
			targetAll = MODE.NEVER;
			
			userAnimation = "idle";
			fxSprite = sBlank;
			effectOnTarget = MODE.ALWAYS;
			hitSound = noone;
			
			
			/// @param {Enum.MOVE_TYPE,array<Enum.MOVE_TYPE>} Type Damage type
			/// @desc Sets damage type of Move, or damage type bonus of Equip.
			/// Takes either a MOVE_TYPE enum or array of MOVE_TYPE enums.
			static setAtkTypes = function(v){ atkTypes = v; infoCard.types = v; return self; };
			
			///@param {string,array<string>} Notation Input string
			///@desc Sets input string for the move (eg: "236L")
			/// Alternatively takes an array of strings (eg: global.moves.fireball)
			static setNotation = function(v){ notation = v; infoCard.input = v; return self; };
			
			///@param {real|string} Submenu Submenu for object to be sorted into
			/// @desc String: sorts into submenu of given key.
			/// -1: Top level menu
			/// -2: Do not sort (hidden)
			static setSubmenu = function(v){ submenu = v; return self; };
			
			///@param {real} Cost
			/// @desc Set EX cost of move.
			static setExCost = function(v){ exCost = v; infoCard.exCost = v; return self; };
			
			///@param {real} Cost
			/// @desc Set how many frames the Move lasts
			static setFrameCost = function(v){ frameCost = v; return self; };
			
			///@param {bool} Target_Requirement
			/// @desc True: Attacks regardless of target.
			/// False: Requires target to be set before use.
			static setTargetRequired = function(v){ targetRequired = v; return self; };
			
			///@param {bool} Target_Side
			/// @desc True: Sets cursor to auto target other side by default.
			/// False: Doesn't.
			static setTargetEnemyByDefault = function(v){ targetEnemyByDefault = v; return self; };
			
			///@param {Enum.MODE} Target_Mode 
			/// @desc MODE.NEVER: Single target attack only.
			/// MODE.ALWAYS: AOE attack only.
			/// MODE.VARIES: Choose between target grouping.
			static setTargetAll = function(v){ targetAll = v; return self; };
			
			///@param {string} Animation 
			static setUserAnim = function(v){ userAnimation = v; return self; };
			static setFxSprite = function(v){ fxSprite = v; return self; };
			static setEffectOnTarget = function(v){ effectOnTarget = v; return self; };
			static setHitSound = function(v){ hitSound = v; return self; };
		
		}
	    
	    global.actionLibrary = 
	    {
	    	// NOTES FOR OPERATION:
	    	
	    	// submenu sets the menu a move is grouped to. 
	    	// -1 is for top level actions, -2 is for moves you don't want to show up in menus (ie normals)
	    	
	    	normals : new Attack("Normals")
	    		.setSubmenu(-1)	
	    		.setUserAnim("idle")
	    		.setFunc(function(user, targets) {
	    			
					with oBattle 
	    			{
	    				sState.change("doNormals");
	    			}
	    		})
	    	,
	    	
	    	enemyNormals : new Attack("enemyNormals")
	    		.setUserAnim("idle")
	    		.setFunc(function(user, targets){
					
	    			with oBattle 
	    			{
	    				oBattle.sState.change("enemyNormals");
	    				oBattle.enemyMove = user.attacks[irandom(array_length(user.attacks)-1)];
	    			}
	    		})
	    	,
	    	
	    	light : new Attack("Jab")
	    		.setNotation("L")
	    		.setUserAnim("normals")
	            .setHitSound(snHit8)
	            .setFrameCost(6)
	            .setFxSprite(sPunch)
	    		.setFunc(function(user, targets) {
	                var damage = ceil(user.stats.str * random_range(1.25,1.5));
	                battleChangeHP(targets[0], -damage,, self.hitSound);
	                battleChangeEX(user,1)
	    		})
	    	,
	        
	        medium : new Attack("Straight")
	    		.setNotation("M")
	    		.setUserAnim("normals")
	            .setHitSound(snHit7)
	            .setFrameCost(8)
	            .setFxSprite(sPunch)
	    		.setFunc(function(user, targets)
	    		{
	    			var damage = ceil(user.stats.str * random_range(1.5,1.75));
	    			battleChangeHP(targets[0], -damage,, hitSound);
	    			battleChangeEX(user,2)
	    		})
	    	,
	        
	        heavy : new Attack("Fierce")
	    		.setNotation("H")
	    		.setUserAnim("normals")
	            .setHitSound(snHit9)
	            .setFrameCost(14)
	            .setFxSprite(sPunch)
	    		.setFunc(function(user, targets)
	    		{
	    			var damage = ceil(user.stats.str * random_range(1.75,2));
	    			battleChangeHP(targets[0], -damage,, hitSound);
	    			battleChangeEX(user,3)
	    		})
	    	,
	        
	        dp : new Attack("Rising Upper")
	    		.setNotation(global.moves.dp)
	    		.setUserAnim("specials")
                .setHitSound(snHit8)
	            .setFrameCost(24)
	            .setExCost(5)
	            .setFxSprite(sPunch)
	            .setTargetAll(MODE.VARIES)
	        
	            .setInfoCard(
	                "Deal fire damage to one"nl"enemy. Can hit multiple targets.",
	                [MOVE_TYPE.PHYS,MOVE_TYPE.FIRE,MOVE_TYPE.STUN],
	                s6+ s2 + s3 + sH
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
	    			for (var i = 0; i< array_length(targets); i++)
	    			{
	    				var damage = ceil(user.stats.exStr + random_range(-user.stats.exStr/3, user.stats.exStr/2));
	    				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
	    				battleChangeHP(targets[i], -damage,, self.hitSound);
	    			}
	    		})
	    	,
            
            devilshot : new Attack("Devil's Gun")
	    		.setNotation(global.moves.fireball)
	    		.setUserAnim("shoot")
                .setSubmenu("Specials")
                .setHitSound(snHit9)
	            .setFrameCost(24)
	            .setExCost(7)
	            .setFxSprite(sPunch)
	        
	            .setInfoCard(
	                "Shoot a big shot of 'Devil Energy'.",
	                [MOVE_TYPE.DEVIL],
	                s2+s3+s6+sL
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
	    			for (var i = 0; i< array_length(targets); i++)
	    			{
	    				var damage = ceil(user.stats.exStr * random_range(1.45,2.25));
	    				if array_length(targets) > 1 {damage = ceil(damage*0.75)}
	    				battleChangeHP(targets[i], -damage,, self.hitSound);
	    			}
	    		})
	    	,
            
            devilVolley : new Attack("Fan Hammer")
	    		.setNotation(global.moves.halfCircle)
	    		.setUserAnim("volley")
                .setSubmenu("Specials")
                .setHitSound(snHit9)
	            .setFrameCost(36)
	            .setExCost(12)
	            .setFxSprite(sPunch)
                .setTargetRequired(false)
	            .setTargetAll(MODE.ALWAYS)
	        
	            .setInfoCard(
	                "Somehow hit everyone"nl"with one bullet.",
	                [MOVE_TYPE.DEVIL],
	                s4+s1+s2+s3+s6+sL
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
	    			for (var i = 0; i< array_length(targets); i++)
	    			{
	    				var damage = ceil((user.stats.exStr * random_range(1.25,1.65))*(0.65 + (user.stats.int/global.lvlCap)));
	    				battleChangeHP(targets[i], -damage, 0, self.hitSound);
	    			}
	    		})
	    	,
            
            heal : new Attack("Healing!","heal")
	    		.setNotation(global.moves.fireball)
	    		.setUserAnim("normals")
                .setSubmenu("Specials")
                .setHitSound(snHealMinor)
	            .setFrameCost(24)
	            .setExCost(10)
	            .setFxSprite(sHeal)
                    
                .setTargetRequired(false)
	            .setTargetAll(MODE.ALWAYS)
                .setTargetEnemyByDefault(false)
	        
	            .setInfoCard(
	                "Heal whoevers health is lowest.",
	                [MOVE_TYPE.HEAL, MOVE_TYPE.LIGHT],
	                s2+s3+s6+sL
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
                    array_sort(targets,function(e1,e2){
                        return  e1.stats.hpMax/e1.stats.hp - e2.stats.hpMax/e2.stats.hp; // should sort whoever in the list has the lowest hp percent? havent tested it yet
                    })
                    var damage = ceil((user.stats.exStr*3) + random_range(-user.stats.exStr/3, user.stats.exStr/2));
                    battleChangeHP(targets[0], damage, 0, self.hitSound);
	    			
	    		})
	    	,
            
            lifesteal : new Attack("Trepanation","heal")
	    		.setUserAnim("normals")
                .setSubmenu("Specials")
                .setHitSound(snHit4)
	            .setFrameCost(24)
	            .setExCost(16)
	            .setFxSprite(sPunch)
                    
                .setTargetRequired(true)
	            .setTargetAll(MODE.NEVER)
	        
	    		.setFunc(function(user, targets)
	    		{
                    var damage = ceil((user.stats.exStr*3) + random_range(-user.stats.exStr/3, user.stats.exStr/2));
                    battleChangeHP(targets[0], damage, 0, self.hitSound);
                    battleChangeHP(user, -damage, 0);
	    			
	    		})
	    	,
            
            healMany : new Attack("Healing Wave","heal")
	    		.setNotation(global.moves.dp)
	    		.setUserAnim("normals")
                .setSubmenu("Specials")
                .setHitSound(snHealMinor)
	            .setFrameCost(24)
	            .setExCost(10)
	            .setFxSprite(sHeal)
                    
                .setTargetRequired(false)
	            .setTargetAll(MODE.ALWAYS)
                .setTargetEnemyByDefault(false)
	        
	            .setInfoCard(
	                "Small heal to all targets.",
	                [MOVE_TYPE.HEAL, MOVE_TYPE.LIGHT],
	                s6+s2+s3+sL // Make a generic "P" input icon for moves that accept any punch
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
                    array_sort(targets,function(e1,e2){
                        return  e1.stats.hpMax/e1.stats.hp - e2.stats.hpMax/e2.stats.hp; // should sort whoever in the list has the lowest hp percent? havent tested it yet
                    })
                    var damage = ceil((user.stats.exStr*3) + random_range(-user.stats.exStr/3, user.stats.exStr/2)*(0.65 + (user.stats.int/global.lvlCap)));
                    battleChangeHP(targets[0], damage, 0, self.hitSound);
	    			
	    		})
	    	,
            
            revive : new Attack("Resurrection!","revive")
	    		.setNotation(global.moves.superart)
	    		.setUserAnim("normals")
                .setSubmenu("Specials")
                .setHitSound(snHealMinor)
	            .setFrameCost(48)
	            .setExCost(16)
	            .setFxSprite(sHeal)
                    
                .setTargetRequired(false)
	            .setTargetAll(MODE.ALWAYS)
                .setTargetEnemyByDefault(false)
	        
	            .setInfoCard(
	                "Revive a dead teammate.",
	                [MOVE_TYPE.REVIVE, MOVE_TYPE.HEAL, MOVE_TYPE.LIGHT],
	                s2+s3+s6+s2+s3+s6+sL
	            )
	        
	    		.setFunc(function(user, targets)
	    		{
                    array_sort(targets,function(e1,e2){
                        return  e1.stats.hpMax/e1.stats.hp - e2.stats.hpMax/e2.stats.hp; // should sort whoever in the list has the lowest hp percent? havent tested it yet
                    })
                    var damage = ceil(targets[0].stats.hpMax *(0.66 + (user.stats.int/global.lvlCap)))
	    			battleChangeHP(targets[0], damage, 1, self.hitSound);
	    			
	    		})
	    	
	    }
	#endregion 	
    	
    struct_foreach(global.actionLibrary, function(moveName, move)
    {
        if variable_struct_exists(move, "info")
        {
           variable_struct_set(move[$ "info"],"exCost", move[$ "exCost"]) ;
        }
    })

    function Character(_name = "", _level = global.areaLevel) constructor{
    
        curve = animcurve_get_channel(acExpCurve,"curve1")
        
        name = _name;
        stats = {
    		
    		lvl : _level,
            EXP : 0,
            requiredEXP : 100,
            
            hp: 0,
            hpMax: 0,
            
            ex: 0,
            exMax: 0,
    
    		str: 0,
    		def: 0,
    		exStr: 0,
    		exDef: 0,
    		int: 0, 
    		spd: 0,
    		cha: 0,
    		luk: 0
    	};
        
        sprites = {};
        actions = [];
		
		atkTypes = [];
		defTypes = [];
        
        ///@param {real} Lvl Level Requirement
    	///@param {real} Exp Bonus Exp Gain (percentage)
    	///@param {real} Hp Bonus Hp Gain (percentage)
    	///@param {real} HpMax Bonus Max Health
    	///@param {real} Str Adds To Stat
    	///@param {real} Def Adds To Stat
    	///@param {real} ExStr Adds To Stat
    	///@param {real} ExDef Adds To Stat
    	///@param {real} Int Adds To Stat
    	///@param {real} Spd Adds To Stat
    	///@param {real} Cha Adds To Stat
    	///@param {real} Luck Adds To Stat
    	///@desc Sets all stat bonuses.
    	static setStats = function(
    		lvl = 0,
    		EXP = 0,
    		hp = 0,
    		hpMax = 0,
            ex = 0,
            exMax = 0,
            requiredEXP = 0,
    		
    		str = 0,
    		def = 0,
    		exStr = 0,
    		exDef = 0,
    		int = 0,
    		spd = 0,
    		cha = 0,
    		luk = 0
    	){
            
            if is_struct(lvl){
                
                var oldStats = stats;
                stats = variable_clone(lvl);
                stats.hp = stats.hpMax
                setLvl(oldStats.lvl)
                return self;
            }
            
            stats.hp = hp;
            stats.ex = ex;
            stats.hpMax = hpMax;
            stats.exMax = exMax;
    		setLvl(lvl);
    		setEXP(EXP);
    	
    		setStr(str);
    		setDef(def);
    		setExStr(exStr);
    		setExDef(exDef);
    		setInt(int);
    		setSpd(spd);
    		setCha(cha);
    		setLuk(luk);
            
    		return self;
    	};
    	
    	static setLvl = function(v){ 
            
            stats.lvl = v; 
            setHp(stats.hp,v)
            setHpMax(stats.hpMax,v)
            setEx(stats.ex,v)
            setExMax(stats.exMax,v)
            
            return self; 
        };
        
    	static setEXP = function(v){ 
            stats.EXP = v; 
            return self; 
        };
        
    	static setHp = function(v = stats.hp, lvl = stats.lvl){ 
            stats.hp = ceil(v * animcurve_channel_evaluate(curve,lvl/global.lvlCap));
            return self; 
        };
    	static setHpMax = function(v = stats.hpMax, lvl = stats.lvl){ 
            stats.hpMax = ceil(v * animcurve_channel_evaluate(curve,lvl/global.lvlCap));
            stats.hp = stats.hpMax;
            return self; 
        };
        static setEx = function(v = stats.ex, lvl = stats.lvl){ 
            stats.ex = ceil(v * animcurve_channel_evaluate(curve,lvl/global.lvlCap));
            return self; 
        };
    	static setExMax = function(v = stats.exMax, lvl = stats.lvl){ 
            stats.exMax = ceil(v * animcurve_channel_evaluate(curve,lvl/global.lvlCap));
            return self; 
        };
        
    	static setStr = function(v){ stats.str = v; return self; };
    	static setDef = function(v){ stats.def = v; return self; };
    	static setExStr = function(v){ stats.exStr = v; return self; };
    	static setExDef = function(v){ stats.exDef = v; return self; };
    	static setInt = function(v){ stats.int = v; return self; };
    	static setSpd = function(v){ stats.spd = v; return self; };
    	static setCha = function(v){ stats.cha = v; return self; };
    	static setLuk = function(v){ stats.luk = v; return self; };
        
        static setActions = function(v){ actions = is_array(v) ? v : [v]; return self; }
        
        static addAction = function(v){ 
            if is_array(v){
                var newactions = array_concat(actions,v)
				actions = newactions;
            } else array_push(actions, v); 
            return self;  
        }
        
        static removeAction = function(v){ array_delete(actions, array_get_index(actions,v), 1) ; return self; }
		
		static setAtkType = function(v){ atkTypes = is_array(v) ? v : [v]; return self; }
		static setDefType = function(v){ defTypes = is_array(v) ? v : [v]; return self; }
        
        static addEXP = function(v)
        {
        	setEXP(stats.EXP + v);
        	show_debug_message($"{name} recieves {v} EXP! {stats.EXP}/{stats.requiredEXP}")
        	
        	if stats.EXP >= stats.requiredEXP {
        		levelUp(self);
        	}
        }
        static levelUp = function()
        {
        	var STATS = stats
        	STATS.EXP -= STATS.requiredEXP;
        	STATS.lvl++;
        	show_debug_message($"{name} is now Level {STATS.lvl}!")
        	
        	var curve = animcurve_get_channel(acExpCurve,"curve1")
        	STATS.requiredEXP = ceil(clamp(STATS.requiredEXP * animcurve_channel_evaluate(curve,STATS.lvl/global.lvlCap),0,99999))
        	
        	STATS.hpMax = ceil(STATS.hpMax * animcurve_channel_evaluate(curve,STATS.lvl/global.lvlCap))
        	STATS.exMax = ceil(STATS.exMax * animcurve_channel_evaluate(curve,STATS.lvl/global.lvlCap))
        	
        	if instance_exists(oBattleResults)
        	{
        		array_push(oBattleResults.level,self)
        		array_push(oBattleResults.stats, [STATS.str,STATS.def,STATS.exStr,STATS.exDef,STATS.int,STATS.spd,STATS.cha,STATS.luk] )
        		array_push(oBattleResults.baseStats, [STATS.str,STATS.def,STATS.exStr,STATS.exDef,STATS.int,STATS.spd,STATS.cha,STATS.luk] )
        	}
        }
  
    };

#endregion

#region character data

    global.equipSlotsTemplate = [
        {
            label : "Armor", 
            type : ITEM_TYPE.ARMOR,
            equip : noone
        },
        {
            label : "Weapon", 
            type : ITEM_TYPE.WEAPON,
            equip : noone
        },
        {
            label : "Mod Slot 1", 
            type : ITEM_TYPE.MOD,
            equip : noone
        },
        {
            label : "Mod Slot 2", 
            type : ITEM_TYPE.MOD,
            equip : noone
        },
    ]    

    function Cowboy(_name, _job, _level = 1) : Character() constructor{
        
        name = _name;
        job = _job;
        
        actions = [ global.actionLibrary.normals, global.actionLibrary.light, global.actionLibrary.medium, global.actionLibrary.heavy ]
        equips = variable_clone(global.equipSlotsTemplate);
        
        allergies = []; //TODO: food effects should be a struct of functions slash statuseffects
        sprites = {};
        battleLines = {};
        
        static setJob = function(v){ job = v; return self; }
        static setBattleLines = function(v){ battleLines = v; return self; }
        
        static setAllergy = function(v){ allergies = is_array(v) ? v : [v]; return self; }
        static addAllergy = function(v){ array_push(allergies, v); return self; }
        static removeAllergy = function(v){ array_delete(allergies, array_get_index(allergies,v), 1) ; return self; }
        
        static setSpriteStruct = function(v){ sprites = v; return self; }
        static setSprite = function(key, val){ sprites[$ key] = val; return self; } 
    }
    
    NILS = new Cowboy(FLAGS.playerName, "Fool")
	.setStats({
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
		int: 0,
		spd: 5,
		cha: 0,
		luk: 5 })
	.setSpriteStruct({ 
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
		parry : sNilsBattleParry })
	.setBattleLines({
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
	})
	.setAllergy([FOOD_TAG.SPICY, FOOD_TAG.SWEETS])
	.addAction([global.actionLibrary.devilshot, global.actionLibrary.devilVolley])
	.setDefType({type : MOVE_TYPE.FIRE, amnt: 60});
	
	CHARLIE = new Cowboy("Charlie", "Magician")
	.setStats({
		lvl : 2,
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
		int: 4,
		spd: 3,
		cha: 0,
		luk: 4
	})
	.setSpriteStruct({ 
		idle: sCharIdle, 
		active: sCharFightActive, 
		normals: sCharParry, 
		slide: sCharIdle, 
		defend: sCharIdle, 
		down: sGrave, 
		head: sHeadChar, 
		portrait: sBattlePortPH, 
		parry : sCharParry})
	.setBattleLines({
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
	})
	.setAllergy([FOOD_TAG.SHELLFISH])
	.addAction([global.actionLibrary.heal, global.actionLibrary.healMany, global.actionLibrary.revive])

	MATTHEW = new Cowboy("Matthew", "Hermit")
	.setStats({
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
		int: 2,
		spd: 5,
		cha: 0,
		luk: 3
	})
	.setSpriteStruct({ 
		idle: sMattIdle, 
		active: sMatthewFightActive, 
		normals: sMattParry,  
		slide: sMattIdle, 
		defend: sMattIdle, 
		down: sGrave, 
		head: sHeadMatt, 
		portrait: sBattlePortPH, 
		parry : sMattParry
	})
	.setBattleLines({
		lowHP : "[shake]ugh-[/shake] I've had worse... [c_dkgrey]dammit...",
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
	})
	.setAllergy([FOOD_TAG.DAIRY])
	.addAction(global.actionLibrary.dp)
	.setDefType({type : MOVE_TYPE.PHYS, amnt: 25});
    
    global.party = [
        NILS,
        CHARLIE,
        MATTHEW,
    ]

#endregion

#region enemy data

    #region definitions 

        // Enemy AI Types
        global.enemyAI = {
        	standard : function(user,targets) {
                
        		var actions = oBattle.unitTurnOrder[oBattle.turn].actions;
        		var action = actions[irandom(array_length(actions)-1)];
        		var actionTypes = []
        			
        		// figure out what kinds of moves the enemy is capable of
        		for (var i = 0; i < array_length(actions); i++)
        		{
        			if !array_contains(actionTypes,action.atkType) {array_push(actionTypes, action.atkType)}
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
        					return action.atkType == "attack";
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
        					return action.atkType == "attack"
        				});
        				action = attacks[irandom(array_length(attacks)-1)];
        			}
        		}
        			
        		// do action
        		switch (action.atkType)
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
        
        global.patterns = { //TODO: Maybe turn enemy patterns into constructor structs? idk how broad its gonna get but i can just do functions for that i guess.
        	
			def : {
                obj : oBullet,
        		dmg : 0,
        		dirs : [0,1,2,3,4,5,6,7],
        		rate : 30,
        		dist : 150,
        		spd : 2,
        	},
        	
        	cross : {
                obj : oBullet,
        		dmg : 0,
        		dirs : [0,2,4,6],
        		rate : 23,
        		dist : 115,
        		spd : 2.25,
        	},
        	
        	plus : {
                obj : oBullet,
        		dmg : 0,
        		dirs : [1,3,5,7],
        		rate : 23,
        		dist : 115,
        		spd : 2.25,
        	},
        	
        	spiral : {
                obj : oBulletBats,
        		dmg : 0,
        		dirs : [],
        		rate : 30,
        		dist : 100,
        		spd : 2.45,
        		funcPerShot : function() { self.dirs[0]++; },
                createFunc : function(){dirs[0] = irandom(7);}
        	},
        	
        	bursts : {
                obj : oBullet,
        		dmg : 0,
        		dirs : [irandom(7)],
        		rate : 20,
        		dist : 150,
        		spd : 2.3,
        		funcPerShot : function() { if oBattleBulletManager.shotsShot mod 3 == 0 {self.dirs[0] += irandom_range(2,5)} },
        	},
        	
        	ant : {
                obj : oBullet,
        		dmg : 1,
        		dirs : [0,1,2,3,4,5,6,7],
        		rate : 20,
        		dist : 150,
        		spd : 5,
        		funcPerShot : function() { oBattle.normalsTimer -= 10},
        	},
        	
        	antDaigo : {
                obj : oBullet,
        		dmg : 1,
        		dirs : [],
        		rate : 11,
        		dist : 150,
        		spd : 4,
                createFunc : function(){dirs[0] = choose(0,4);}
        	},
        }
        
        struct_foreach(global.patterns, function(_key, _val)
        {
        	if _val[$ "funcPerShot"] == undefined { _val.funcPerShot = function(){} }
        	if _val[$ "createFunc"] == undefined { _val.createFunc = function(){} }
        })

    #endregion

    ///@param {string} Name
    ///@param {real} Level
    ///@param {struct,array<struct>} Actions
    ///@param {string,array<string>} Patterns
    ///@param {real} xpValue
    function Enemy(_name, _sprite, _xp = global.areaLevel*5, _actions = [ global.actionLibrary.enemyNormals ], _attacks = ["def"], _level = global.areaLevel) : Character() constructor{
        
        name = _name;
        stats.lvl = _level;
        
        sprites = { idle: _sprite, normals: _sprite, defend: _sprite, down: sGrave, head: _sprite}
        
        setActions(_actions);
        setAttacks(_attacks);
        setXpWorth(_xp);
        
        AI = global.enemyAI.standard;
        
        static setAttacks = function(v){ attacks = is_array(v) ? v : [v]; return self; }
        
        static addAttack = function(v){ 
            
            if is_array(v){
                attacks = array_concat(attacks,v)
            } else array_push(attacks, v); 
            return self; 
        };
        
        static removeAttack = function(v){ 
            
            if is_array(v){
                array_foreach(v,function(element, index){
                    array_delete(attacks, array_get_index(attacks,element), 1)
                })
            } else array_delete(attacks, array_get_index(attacks,v), 1) ;
            
            return self; 
        };
        
        static setXpWorth = function(v){ 
            
            var curve = animcurve_get_channel(acExpCurve,"curve1")
            xpWorth = ceil(clamp(v * animcurve_channel_evaluate(curve,stats.lvl/global.lvlCap),0,99999))
            return self;
        };
    };
    
    // Enemies
    global.enemies = {
        
    sand: new Enemy("Sand",sSand,6)
        .addAttack("bursts")
        .setStats({
            hpMax: 30,
            ex: 10,
            exMax: 10,
            str: 14,
            def : 2,
            exStr: 5,
            spd : 4
        })
    ,
    
    bat: new Enemy("Swoopty",sBat,6)
        .addAction([global.actionLibrary.revive,global.actionLibrary.lifesteal])
        .setAttacks("spiral")
        .setStats({
            hpMax: 25,
            ex: 15,
            exMax: 15,
            str: 12,
            def: 1,
            exStr: 6,
            spd : 4
        })
    ,
    
    ant: new Enemy("Feral Ant",sAnt,4,,["ant","antDaigo"])
        .setStats({
            hpMax: 15,
            ex: 15,
            exMax: 15,
            str: 15,
            def: 0,
            exStr: 6,
            spd : 6
        })
    ,
                
    cactus:new Enemy("Okey-Pokey",sOkeyPokey,7,,["plus","cross","cross"])
        .setStats({
            hpMax: 35,
            ex: 15,
            exMax: 15,
            str: 13,
            def: 1,
            exStr: 6,
            spd : 4
        })
    }

#endregion

initItems();