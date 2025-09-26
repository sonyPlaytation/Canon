/// @

//partyData

//TODO: make battles happen in a room instead of an object... because this SUCKS ass

createTransition(sqFightIn);
oCamera.follow = id;
enemies = global.fightEnemies
creator = global.fightStarter

pauseGame()
global.canPause = false;

_x = room_width/2
_y = room_height/2

bgm = mBattleNeut
advantage = global.advantage;
units = [];
btlText = [];

perfect = true;

partyHP = 0;
partyHPMAX = 0;
partyHPPercent = 0;

enemyHP = 0;
enemyHPMAX = 0;
enemyHPPercent = 0;

normalsCooldown = 0;

bgx = [0,0,0];

stateName = ""

slide = noone;
slideDone = false;
slideDist = 24;
slideTime = 180

parriesMissed = 0;
enemyMove = "";

normalsPerformed = 0;
normalsAllowed = 6;
normalsReset = 3 * 60
normalsTimer = normalsReset;
normalsString = "";
enemyTurnDone = false;

battleJustStarted = 60;

turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];
killsPerTurn = 0;

turnCount = 0;
roundCount = 1;
battleWaitTimeFrames = 15;
battleWaitTimeLeft = 0;
currentUser = 0;
currentAction = -1;
currentTargets = noone;

postParryCounter = false;

potExp = 0;

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
	var enemy = enemies[i]
	enemyUnits[i] = instance_create_depth(x+200+(i*20), y + 68 + (i*30), depth-(20 + i), oBattleEnemy, enemy);
	enemyUnits[i].stats = variable_clone(enemy.stats)
	potExp += enemy.xpWorth
	enemyHPMAX += enemyUnits[i].stats.hpMax;
	array_push(units,enemyUnits[i]);
}

for (var i = 0; i < array_length(PARTY); i++)
{
	partyUnits[i] = instance_create_depth(x-200-(i*30), y + 68 + (i*30), depth-(20 + i), oBattleHero, global.party[i]);
	partyUnitsFixed[i] = global.party[i];
	partyHPMAX += partyUnits[i].stats.hpMax;
	array_push(units,partyUnits[i]);
}

partyHPStart = partyHPMAX;

if array_length(enemyUnits) > 1
{ BATTLE("{0} and cohorts draw near!",enemyUnits[0].name,"") }
else
{ BATTLE("{0} draws near!",enemyUnits[0].name,""); }

//shuffle turn order
randomize();

var sortBySpd = function(arr)
{
	array_sort(arr,function(unit1,unit2)
	{
		return  unit2.stats.spd - unit1.stats.spd;
	})
	return arr;
}

switch(advantage)
{
	case 1:
		BATTLE("[c_lime]You have the upper hand! Press this advantage!");
		unitTurnOrder = array_concat(sortBySpd(partyUnits),sortBySpd(enemyUnits));
		bgm = mBattleAdv;
	break;
	
	case -1:
		BATTLE("[c_red]Look out! You're completely surrounded!");
		unitTurnOrder = array_concat(sortBySpd(enemyUnits),sortBySpd(partyUnits));
		bgm = mBattleDisadv;
	break;
	
	default:
	case 0:
		BATTLE("[c_yellow]It all depends on your skill. Go for broke!");
		unitTurnOrder = sortBySpd(units);
		
	break;
}

partyTurnOrder = array_filter(unitTurnOrder,function(element,index)
{
	return array_contains(partyUnits,unitTurnOrder[index])
})

partyHealthbar = instance_create_depth(x,y,-10000,oBattleHealth,
{
	turnOrder : partyTurnOrder,
	enemy : false
})

enemyHealthbar = instance_create_depth(x,y,-10000,oBattleHealth,
{
	enemy : true
})
enemyHealthbar.enemy = true;

if global.fightSong != -1 {bgm = global.fightSong}

set_song_ingame(bgm,,,true);

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

beginAction = function(user, action, targets) // THIS IS A FUNCTION NOT A STATE
{
	stateName = "beginAction"
	currentUser = user;
	currentAction = action;
	currentTargets = targets;
	
	if !is_array(currentTargets) {currentTargets = [currentTargets]};
	
	if variable_struct_exists(currentAction,"description")
	{
		if array_length(currentTargets) > 1
		{
			BATTLE(currentAction.description + $" x{array_length(currentTargets)}", currentUser.name, currentTargets[0].name)
		}
		else BATTLE(currentAction.description, currentUser.name, currentTargets[0].name);
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
	sState.change("performAction");
}

checkNormalsString = function()
{
	if string_pos("lmh",normalsString){show_debug_message("Plink detected")};
	
	if killsPerTurn == 2 {BATTLE("[#F16EAA]HAPPY BIRTHDAY!")}
	else if killsPerTurn == 3 {BATTLE("[c_red]MERRY [c_green]CHRISTMAS!!")}
}

useCursor = function()
{
	// cursor
	if cursor.active
	{
		with cursor
		{
			if confirmDelay == 0
			{ InputVerbConsumeAll(); }
			confirmDelay++;	
		
			var moveH = InputPressed(INPUT_VERB.RIGHT) - InputPressed(INPUT_VERB.LEFT);
			var moveV = InputPressed(INPUT_VERB.DOWN) - InputPressed(INPUT_VERB.UP);
		
			if moveH == -1 {targetSide = oBattle.partyUnits;} else if moveH == 1 {targetSide = oBattle.enemyUnits;}
		
			if targetSide == oBattle.enemyUnits
			{
				targetSide = array_filter(targetSide, function(_element, _index)
				{
					return _element.stats.hp > 0;	
				})	
			}
		
			if (targetAll == false)
			{
				if moveV > 0 {targetIndex++;} else if moveV < 0 targetIndex--;
			
				var targets = array_length(targetSide)
				if targetIndex < 0 {targetIndex = targets-1;}
				if targetIndex > targets-1 {targetIndex = 0;}
			
				activeTarget = targetSide[targetIndex];
			
				if activeAction.targetAll == MODE.VARIES and InputPressed(INPUT_VERB.SKIP)
				{
					targetAll = true;
				}
			}
			else
			{
				activeTarget = targetSide;	
				if activeAction.targetAll == MODE.VARIES and InputPressed(INPUT_VERB.SKIP)
				{
					targetAll = false;
				}
			}
		
			if InputPressed(INPUT_VERB.ACCEPT)
			{
				with (oBattle) beginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
				with (oMenu) destroyMenu = true;
				active = false;
				confirmDelay = 0;
			}
			else if InputPressed(INPUT_VERB.CANCEL)
			{
				with (oMenu) active = true;
				active = false;
				confirmDelay = 0;
			}
		}
	}	
}

battleStates()
