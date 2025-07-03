/// @

//partyData
audio_play_sound(mBattlePlaceholder,500,true);

createTransition(sqFightIn);

instance_deactivate_all(true);
instance_activate_object(oCamera);
instance_activate_object(oGame);
instance_activate_object(__InputUpdateController);
instance_activate_object(__obj_stanncam_manager);

_x = x - (GAME_W/2)
_y = y - (GAME_H/2)

units = [];

slide = noone;
slideDone = false;
slideDist = 24;

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

//shuffle turn order
randomize();
unitTurnOrder = array_shuffle(units);

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
			
			var _actionList = unit.actions;
			
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _avail = true;
				var _nameAndCount = action.name;
				
				if _action.subMenu == -1
				{
					array_push(_menuOptions, [_nameAndCount, menuSelectAction, [unit, _action], _avail])	
				}
				else
				{
					if is_undefined(_subMenus[$ _action.subMenu])
					{
						variable_struct_set(_subMenus, _action.subMenu, [[ _nameAndCount, menuSelectAction, [unit, _action], _avail ]]);
					}
					else array_push(_subMenus[$ _action.subMenu], [ _nameAndCount, menuSelectAction, [unit, _action], _avail ]);
				}
			}
		}
		else if unit.object_index == oBattleEnemy
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
	state = turnProgress;
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

state = selectAction;