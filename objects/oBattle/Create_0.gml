/// @

//partyData

createTransition(sqFightIn);

pauseGame()

_x = x - (GAME_W/2)
_y = y - (GAME_H/2)

bgm = mBattleNeut
advantage = global.advantage;
units = [];
btlText = [];

slide = noone;
slideDone = false;
slideDist = 24;

normalsPerformed = 0;
normalsAllowed = 6;
normalsReset = 3 * 60
normalsTimer = normalsReset;
normalsString = "";

battleJustStarted = 60;

turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 15;
battleWaitTimeLeft = 0;
currentUser = 0;
currentAction = -1;
currentTargets = noone;

cursor = 
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	targetSide: -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active: false
}

for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+200+(i*20), y + 68 + (i*30), depth-(20 + i), oBattleEnemy, enemies[i]);
	array_push(units,enemyUnits[i]);
}

for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x-200-(i*20), y + 68 + (i*30), depth-(20 + i), oBattleHero, global.party[i]);
	array_push(units,partyUnits[i]);
}

if array_length(enemyUnits) > 1
{ new battleText("{0} and cohorts draw near!",enemyUnits[0].name,"") }
else
{ new battleText("{0} draws near!",enemyUnits[0].name,""); }

//shuffle turn order
randomize();

switch(advantage)
{
	case 1:
		BATTLE("[c_lime]You have the upper hand! Press this advantage!");
		unitTurnOrder = array_concat(array_shuffle(partyUnits),array_shuffle(enemyUnits));
		bgm = mBattleAdv;
	break;
	
	case -1:
		BATTLE("[c_red]Look out! You're completely surrounded!");
		unitTurnOrder = array_concat(array_shuffle(enemyUnits),array_shuffle(partyUnits));
		bgm = mBattleDisadv;
	break;
	
	default:
	case 0:
		BATTLE("[c_yellow]It all depends on your skill. Go for broke!");
		unitTurnOrder = array_shuffle(units);
		
	break;
}

if global.fightSong != -1 {bgm = global.fightSong}

set_song_ingame(bgm);

refreshRenderOrder = function()
{
	unitRenderOrder = [];	
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1,_2)
	{
		return _1.y - _2.y;
	});
}
refreshRenderOrder();

selectAction = function()
{
	if battleJustStarted > 0 {battleJustStarted--};
	
	if !instance_exists(oMenu)
	{
		var unit = unitTurnOrder[turn];
	
		if variable_struct_exists(unit.sprites,"active"){ unit.sprite_index = unit.sprites.active; }
	
		if !instance_exists(unit) or unit.hp <= 0
		{
			state = victoryCheck;
			exit;
		}
	
		if unit.object_index == oBattleHero 
		{
			var _menuOptions = []
			var _subMenus = {}
			
			// get all listed actions as an array from current unit
			var _actionList = unit.actions;
			
			// "Packaging" all options into their intended submenus
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _avail = true;
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
}

beginAction = function(user, action, targets)
{
	currentUser = user;
	currentAction = action;
	currentTargets = targets;
	
	if !is_array(currentTargets) {currentTargets = [currentTargets]};
	
	if variable_struct_exists(currentAction,"description")
	{
		if array_length(currentTargets) > 1
		{
			new battleText(currentAction.description + $" x{array_length(currentTargets)}", currentUser.name, currentTargets[0].name)
		}
		else new battleText(currentAction.description, currentUser.name, currentTargets[0].name);
	}
	
	battleWaitTimeLeft = battleWaitTimeFrames
	
	with (user)
	{
		acting = true;
		if !is_undefined(action[$ "userAnimation"]) and !is_undefined(user.sprites[$ action.userAnimation])
		{
			sprite_index = sprites[$ action.userAnimation];
			image_index = 0;
		}
	}
	state = stateSlideIn;
}

stateSlideIn = function()
{
	currentUser.x = lerp(currentUser.x, currentUser.xstart + (slideDist*currentUser.image_xscale), 0.25);
	if abs(ceil(point_distance(currentUser.xstart,y, currentUser.x,y ))) == slideDist {state = performAction;}
}

doNormals = function()
{
	var char = "";
	currentAction = -1;
	normalsTimer--;
	
	if currentTargets[0].hp <= 0 // if current target dies before time is up
	{
		//find random living target and switch to them instead
		var livingTargets = array_filter(enemyUnits, function(_element, _index)
		{
			return _element.hp > 0;	
		});
		
		array_shuffle(livingTargets);
		
		if array_length(livingTargets) >= 1 
		{ currentTargets[0] = livingTargets[0] } 
		else { state = stateSlideOut }
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
					new battleText(currentAction.description + $" x{array_length(currentTargets)}", currentUser.name, currentTargets[0].name)
				}
				else new battleText(currentAction.description, currentUser.name, currentTargets[0].name);
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
		normalsTimer = normalsReset
		state = stateSlideOut;
	}
}

performAction = function()
{
	
	if slideDone or slide == noone
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
					state = stateSlideOut;
				}
			}
		}
	}	
}

stateSlideOut = function()
{
	currentUser.x = lerp(currentUser.x, currentUser.xstart, 0.25);
	if abs(floor(point_distance(currentUser.xstart,y, currentUser.x,y ))) == 0 {state = victoryCheck;}
}

victoryCheck = function()
{
	var enemiesDead = 0;
	for (var i = 0; i < array_length(enemyUnits); i++)
	{
		if enemyUnits[i].hp <= 0 {enemiesDead++}
	}
	
	var partyDead = 0;
	for (var i = 0; i < array_length(partyUnits); i++)
	{
		if partyUnits[i].hp <= 0 {partyDead++}
	}
	
	if enemiesDead == array_length(enemyUnits) // win condition
	{
		set_song_ingame(mPlaceholderBattleWin)
		with oBattleHero 
		{
			if hp <= 0 {battleChangeHP(self, 1, 1)};
			sprite_index = sprites.active
		}
		
		btlText = []
		BATTLE("[c_lime][wave]YOU WIN!")
		
		state = victory;
	}
	else if partyDead == array_length(partyUnits) // lose condition
	{
		set_song_ingame(mPHAllDied)
		
		btlText = []
		BATTLE("[c_red][shake]YOU LOSE!")
		
		state = victory;
	}
	else state = turnProgress;
}

victory = function()
{
	if InputPressed(INPUT_VERB.ACCEPT)
	{
		if !instance_exists(oResultsScreen)
		{
			instance_create_depth(_x, _y-24 , depth - 100,oResultsScreen)
		}
		//transition(room, sqBattleEnd, sqFadeIn, true);
	}
}

defeat = function()
{
	
}

turnProgress = function()
{
	turnCount++;
	turn++;
	if (turn > array_length(unitTurnOrder)-1)
	{
		turn = 0;
		roundCount++;
	}
	state = selectAction;
}

checkNormalsString = function()
{
	if string_pos("lmh",normalsString){show_debug_message("Plink detected")};
	
	
	
}

state = selectAction;