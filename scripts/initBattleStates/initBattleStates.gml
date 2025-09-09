function initBattleStates(){

	sState = new SnowState("selectAction");

	sState.add("selectAction",
	{
		enter : function()
		{
			var unit = unitTurnOrder[turn];
	
			if unit.stats.hp > 0 and variable_struct_exists(unit.sprites,"active"){ unit.sprite_index = unit.sprites.active; }
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
					victoryCheck();
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
				
						if _action.subMenu == -1 // if Top Level action, not submenu
						{
							// _menuOptions is the Top Level Menu
							array_push(_menuOptions, [_nameAndCount, menuSelectAction, [unit, _action], _avail])	
						}
						else
						{
							// if current subMenu does not exist in the struct containing all the subMenus
							if is_undefined(_subMenus[$ _action.subMenu])
							{	// I still dont know why this part is double arrayed? idk what thats doing for it
								variable_struct_set(_subMenus, _action.subMenu, [[ _nameAndCount, menuSelectAction, [unit, _action], _avail ]]);
							}
							else array_push(_subMenus[$ _action.subMenu], [ _nameAndCount, menuSelectAction, [unit, _action], _avail ]);
						}
					}
			
					//turn submenus into array
					var _subMenusArray = variable_struct_get_names(_subMenus);
					for (var i = 0; i < array_length(_subMenusArray); i++)
					{
						//can sort submenu stuff here but i dont think i need to
						array_push(_subMenus[$ _subMenusArray[i]], ["Back", menuGoBack, -1, true]);
						// add submenus we just created into the greater menu
						array_push(_menuOptions, [_subMenusArray[i], subMenu, [_subMenus[$ _subMenusArray[i]]], true] );
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
			currentUser.sprite_index = currentUser.sprites.attack
		}
		,
		step : function()
		{
			if currentUser.percent >= currentUser.percentTarg
			{
				if currentUser.acting
				{
					if (currentUser.image_index >= image_number-1)
					{
						with(currentUser)
						{
							sprite_index = sprites.idle	
							image_index = 0;
							acting = false;
						}
			
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
						currentAction.func(currentUser,currentTargets);
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
			//postParryCounter = false;	
		}
	})


	.add("doNormals",
	{
		step : function()
		{
			var char = "";
			currentAction = -1;
			normalsTimer--;
	
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
				else { victoryCheck(); }
			}
	
			if normalsAllowed > normalsPerformed and normalsTimer > 0
			{
				if InputPressed(INPUT_VERB.BL)		{currentAction = global.actionLibrary.light		char = "l" }
				else if InputPressed(INPUT_VERB.BM)	{currentAction = global.actionLibrary.medium	char = "m" }
				else if InputPressed(INPUT_VERB.BH)	{currentAction = global.actionLibrary.heavy		char = "h" }
		
				if char != ""
				{
					normalsString += char;
					char = "";
				}
		
				if currentAction != -1 and normalsTimer > currentAction.frameCost
				{
					if variable_struct_exists(currentAction,"description")
					{
						if array_length(currentTargets) > 1
						{
							BATTLE(currentAction.description + $" x{array_length(currentTargets)}", currentUser.name, currentTargets[0].name)
						}
						else BATTLE(currentAction.description, currentUser.name, currentTargets[0].name);
					}
			
					currentAction.func(currentUser,currentTargets);
					normalsTimer -= currentAction.frameCost;
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
				}
			}else 
			{
				checkNormalsString();
				normalsString = "";
				normalsPerformed = 0
				killsPerTurn = 0;
				normalsTimer = normalsReset
				victoryCheck();
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
		step : function()
		{
			var defender = currentTargets[0]
	
			if !instance_exists(oBattleDefenseManager) and !enemyTurnDone
			{
				parryWidget = instance_create_depth(x,y,depth-10,oBattleDefenseManager,
				{
					defender : defender,
					user : currentUser
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
				normalsString = "";
				normalsPerformed = 0
				normalsTimer = normalsReset
				if parriesMissed == 0 
				{
					BATTLE("[c_aqua]PERFECT PARRIES! Now go for a counter-attack!!");
					postParryCounter = true;
					sState.leave();
					beginAction(currentTargets[0].id, global.actionLibrary.normals, currentUser.id);
				}
				else sState.change("victoryCheck");
				parriesMissed = 0 
			}
		}
		,
		leave : function()
		{
			currentUser.forward = false;
		}
	})
	
	.add("victoryCheck",
	{
		enter : function()
		{
			
		}
		,
		step : function()
		{
			stateName = "victoryCheck"
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
				endBattle()
			}
			else if partyDead == array_length(partyUnits) // lose condition
			{
				set_song_ingame(mGameOver,,,true)
		
				BATTLE("[c_red][shake]YOU LOSE!")
		
				endBattle()
			}
			else sState.change("turnProgress");
		}
	})
	
	.add("victory",
	{
		enter : function()
		{

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
	
	.add("turnProgress",
	{
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
	})

}