function battleStates(){

	sState = new SnowState("selectAction");

	sState.add("selectAction",
	{
		enter : function()
		{
			var unit = unitTurnOrder[turn];
            currentUser = unit;
			show_debug_message($"START OF {unit.name}'S TURN")
			unit.acting = false;
	
			if unit.stats.hp > 0 and variable_struct_exists(unit.sprites,"active"){ unit.sprite_index = unit.sprites.active; }
	
			//todo fix turn order
			//if unit.stats.hp > 0 and array_contains(partyUnits,unit)
			//{
			//	array_delete(oBattle.partyTurnOrder,0,1) 
			//	oBattle.partyTurnOrder[2] = unit 
			//}
		}
		,
		step : function()
		{
			var unit = unitTurnOrder[turn];
		
			if battleJustStarted > 0 {battleJustStarted--};
	
			if !instance_exists(oMenu)
			{
				if !instance_exists(unit) or unit.stats.hp <= 0
				{
					sState.change("victoryCheck")
					exit;
				}
	
				if unit.object_index == oBattleHero 
				{
					var _menuOptions = []
					var _subMenus = {}
			
					// get all listed actions as an array from current unit
					var _actionList = array_concat(unit.actions, global.inv[ITEM_TYPE.CONSUMABLE])
			
					// "Packaging" all options into their intended submenus
					for (var i = 0; i < array_length(_actionList); i++)
					{
						var _action = _actionList[i];
						var _avail = true; // check EX cost here
						var _nameAndCount = _action.name;
						var _info = _action[$ "info"]
				
						if _action.subMenu == -1 // if Top Level action, not submenu
						{
							// _menuOptions is the Top Level Menu
							array_push(_menuOptions, [_nameAndCount, menuSelectAction, [unit, _action], _avail, _info])	
						}
						else if _action.subMenu != -2
						{
							// if current subMenu does not exist in the struct containing all the subMenus
							if is_undefined(_subMenus[$ _action.subMenu])
							{	// I still dont know why this part is double arrayed? idk what thats doing for it
								variable_struct_set(_subMenus, _action.subMenu, [[ _nameAndCount, menuSelectAction, [unit, _action], _avail, _info ]]);
							}
							else array_push(_subMenus[$ _action.subMenu], [ _nameAndCount, menuSelectAction, [unit, _action], _avail, _info ]);
						}
					}
			
					//turn submenus into array
					var _subMenusArray = variable_struct_get_names(_subMenus);
					for (var i = 0; i < array_length(_subMenusArray); i++)
					{
						//can sort submenu stuff here but i dont think i need to
						array_push(_subMenus[$ _subMenusArray[i]], ["Back", submenuGoBack, -1, true, undefined]);
						// add submenus we just created into the greater menu
						array_push(_menuOptions, [_subMenusArray[i], subMenu, [_subMenus[$ _subMenusArray[i]]], true, undefined] );
					}
			
					var menu = Menu( _x + 24, _y + (TILE_SIZE * 5), _menuOptions, , 74, 128);
					menu.actorName = unit.name
				}
				else if unit.object_index == oBattleEnemy and battleJustStarted == 0
				{
					var enemyAction = unit.AI();
					if (enemyAction != -1)
					{ beginAction(unit.id, enemyAction[0], enemyAction[1]); }
				}
			}
	
			useCursor();
		}
	})

	.add("performAction",
	{
		enter : function()
		{
			currentUser.forward = true;
			currentUser.image_index = 0;
			if currentUser.sprites[$ "slide"] != undefined { currentUser.sprite_index = currentUser.sprites.slide}
		}
		,
		step : function()
		{
			if currentUser.percent >= currentUser.percentTarg 
			{
                currentUser.acting = true
				if variable_struct_exists(currentAction, "userAnimation")
				{
					var anim = struct_get(currentAction, "userAnimation");
					if currentUser.sprites[$ anim ] != undefined and currentUser.sprite_index != currentUser.sprites[$ anim ] 
					{ currentUser.image_index = 0; currentUser.sprite_index = currentUser.sprites[$ anim ];  }
				}
				
				if currentUser.acting 
				{
                    if !perform exit;
					if sprite_get_speed(currentUser.sprite_index) < 1 or (currentUser.image_index >= (currentUser.image_number-1)/2)
					{ 
						if (currentUser.image_index >= (currentUser.image_number-1)) { currentUser.image_speed = 0; }
			
						if variable_struct_exists(currentAction, "fxSprite")
						{
							if currentAction.effectOnTarget == MODE.ALWAYS or (currentAction.effectOnTarget == MODE.VARIES and array_length(currentTargets) <= 1)
							{
								for (var i = 0; i < array_length(currentTargets); i++) {
									instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth-1,oBattleEffect,{sprite_index : currentAction.fxSprite});
								}	
							}
							else 
							{
								var _fxSprite = currentAction.fxSprite;
								if variable_struct_exists(currentAction,"fxSpriteNoTarget") {_fxSprite = currentAction.fxSpriteNoTarget};
								instance_create_depth(x,y,depth-100,oBattleEffect,{sprite_index : _fxSprite});
							}
						}
					
						currentUser.acting = false;
						if perform { currentAction.func(currentUser,currentTargets) }
                        perform = false;
					}
					
				}
				else
				{
					if !instance_exists(oBattleEffect)
					{
						battleWaitTimeLeft--;
						if battleWaitTimeLeft <= 0
						{
							currentUser.forward = false;
							sState.change("victoryCheck");
							postParryCounter = false;	
						}
					}
				}
			}	
		}
		,
		leave : function()
		{
			currentUser.sprite_index = currentUser.sprites.idle;
			currentUser.image_speed = 1;
            currentUser.acting = false;
		}
	})


	.add("doNormals",
	{
		step : function()
		{
			var char = "";
			currentUser.acting = true;
			currentAction = -1;
			normalsTimer--;
			if normalsCooldown > 0 {normalsCooldown--}
	
			if currentTargets[0].stats.hp <= 0 // if current target dies before time is up
			{
				killsPerTurn++
				//find random living target and switch to them instead
				var livingTargets = array_filter(enemyUnits, function(_element, _index)
				{
					return _element.stats.hp > 0;	
				});
		
				array_shuffle(livingTargets);
		
				if array_length(livingTargets) >= 1 
				{ currentTargets[0] = livingTargets[0] } 
				else if currentUser.image_index == 0 { sState.change("victoryCheck"); }
			}
	
			if normalsAllowed > normalsPerformed and normalsTimer > 0
			{
				checkNormalsString();
		
				if currentAction != -1 and normalsCooldown == 0
				{
					if variable_struct_exists(currentAction,"description")
					{
						if array_length(currentTargets) > 1
						{
							BATTLE(currentAction.description + $" x{array_length(currentTargets)}", currentUser.name, currentTargets[0].name)
						}
						else BATTLE(currentAction.description, currentUser.name, currentTargets[0].name);
					}
					
					if currentAction.targetAll {currentTargets = enemyUnits}
					currentAction.func(currentUser,currentTargets);
					with currentUser
					{
						if !is_undefined(other.currentAction[$ "userAnimation"]) and !is_undefined(other.currentUser.sprites[$ other.currentAction.userAnimation])
						{
							sprite_index = sprites[$ other.currentAction.userAnimation];
							image_index = 0;
						}
					}
					
					if currentAction[$ "frameCost"] != undefined
					{
						normalsTimer -= currentAction.frameCost;
						normalsCooldown = currentAction.frameCost/2;
					}
					normalsPerformed++;	
			
					if variable_struct_exists(currentAction, "fxSprite")
					{
						if currentAction.effectOnTarget == MODE.ALWAYS or (currentAction.effectOnTarget == MODE.VARIES and array_length(currentTargets) <= 1)
						{
							for (var i = 0; i < array_length(currentTargets); i++) {
								instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth-1,oBattleEffect,{sprite_index : currentAction.fxSprite});
							}	
						}
						else 
						{
							var _fxSprite = currentAction.fxSprite;
							if variable_struct_exists(currentAction,"fxSpriteNoTarget") {_fxSprite = currentAction.fxSpriteNoTarget};
							instance_create_depth(x,y,depth-100,oBattleEffect,{sprite_index : _fxSprite});
						}
					}
			
					currentAction = -1;
					moveString = "";
				}
			}else 
			{
                if currentUser.image_number < 2 or (currentUser.image_index >= currentUser.image_number)
                {
                    normalsCooldown = 0;
    				moveString = "";
    				normalsPerformed = 0
    				killsPerTurn = 0;
    				normalsTimer = normalsReset
    				sState.change("victoryCheck");
                }
				
			}
		}
		,
		leave : function()
		{
			currentUser.forward = false;
		}
	})
	
	.add("enemyNormals",
	{
        enter : function()
        {
            textAlphaTarg = 0;
        },
		step : function()
		{
			var defender = currentTargets[0]
	
			if !instance_exists(oBattleDefenseManager) and !enemyTurnDone
			{
				parryWidget = instance_create_depth(x,y,depth-10,oBattleDefenseManager,
				{
					defender : defender,
					user : currentUser,
					enemyMove : enemyMove
				});
			}
	
			if defender.stats.hp > 0 and normalsTimer > 0 {normalsTimer -= 0.5;} 
			else
			{
				enemyTurnDone = true
				with pBattleDefense {pleaseWrapItUp = true}
			}
	
			if enemyTurnDone and !instance_exists(parryWidget)
			{
		
				enemyTurnDone = false
				checkNormalsString();
				moveString = "";
				normalsPerformed = 0
				normalsTimer = normalsReset
				if parriesMissed == 0 
				{
					BATTLE("[c_aqua]PERFECT PARRIES! Now go for a counter-attack!!");
					postParryCounter = true;
					sState.leave();
					beginAction(defender.id, global.actionLibrary.normals, currentUser.id);
				}
				else sState.change("victoryCheck");
				parriesMissed = 0 
			}
		}
		,
		leave : function()
		{
            textAlphaTarg = 1;
			currentUser.forward = false;
		}
	})
	
	.add("victoryCheck",
	{
		step : function()
		{
			var enemiesDead = 0;
			for (var i = 0; i < array_length(enemyUnits); i++)
			{
				if enemyUnits[i].stats.hp <= 0 {enemiesDead++}
			}
	
			var partyDead = 0;
			for (var i = 0; i < array_length(partyUnits); i++)
			{
				if partyUnits[i].stats.hp <= 0 {partyDead++}
			}
	
			if enemiesDead == array_length(enemyUnits) // win condition
			{
				//instance_destroy(oBattleHealth)
				sState.change("victory");
			}
			else if partyDead == array_length(partyUnits) // lose condition
			{
				//instance_destroy(oBattleHealth)
				sState.change("defeat");
			}
			else sState.change("turnProgress");
		}
	})
	
	.add("victory",
	{
		enter : function()
		{
			set_song_ingame(mBattleWin,,,true)
			BATTLE("[c_lime][wave]YOU WIN![/wave]")
		
			for (var i = 0; i < array_length(partyUnits); i++ )
			{
				if partyUnits[i].stats.hp <= 0 {battleChangeHP(partyUnits[i], 1, 1)};
				partyUnits[i].sprite_index = partyUnits[i].sprites.active
                partyUnits[i].acting = false;
			}
			
			for (var i = 0; i < array_length(partyUnits); i++) 
			{
				PARTY[i].stats.hp = partyUnitsFixed[i].stats.hp;
				//PARTY[i].stats.ex = partyUnits[i].stats.ex; 
			}
		
			var winQuoteSayer = partyUnits[irandom(array_length(partyUnits)-1)];
			winQuote = "["+sprite_get_name(winQuoteSayer.sprites.head)+"]: "+chr(34)+winQuoteSayer.battleLines.winQuotes[irandom(array_length(winQuoteSayer.battleLines.winQuotes)-1)]+chr(34);
			winHead = winQuoteSayer.sprites.head
			
		}
		,
		step : function()
		{
			if !instance_exists(oBattleResults) and InputPressed(INPUT_VERB.ACCEPT)
			{
				var _killsList = ["Enemies Defeated"]
				for (var i = 0; i < array_length(enemyUnits); i++)
				{
					array_push(_killsList, enemies[i].name)
				}
		
				instance_create_depth(x,y,depth-100,oBattleResults,
				{
					encounterEXP : potExp,
					killsList : _killsList,
					winQuote : winQuote,
					winHead : winHead
				})
			}
		}
	})
	
	.add("defeat",
	{
		enter : function()
		{
			//set_song_ingame(mGameOver,,,true)
			//BATTLE("[c_red][shake]YOU LOSE![/shake]")
			shortMessage("you died",TXTPOS.MID)
            global.fightStarter = noone;
		}
		,
		step : function()
		{
			if InputPressed(INPUT_VERB.ACCEPT)
			{
				transition(room, sqBattleEnd, sqFadeIn, true);
				loadGame(true)
			}
		}
	})
	
	.add("turnProgress",
	{
		enter : function()
		{
			
		}
		,
		step : function()
		{
			turnCount++;
			turn++;
			if (turn > array_length(unitTurnOrder)-1)
			{
				turn = 0;
				roundCount++;
			}
			sState.change("selectAction");
		}
		,
		leave : function()
		{
		
			
			
		}
	})

}