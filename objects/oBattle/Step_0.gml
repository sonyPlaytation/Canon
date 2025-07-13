/// @

pBattleUnit.visible = false;

state();

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
				return _element.hp > 0;	
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
			with (oMenu) instance_destroy();
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