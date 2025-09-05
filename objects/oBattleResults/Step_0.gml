/// @

if InputPressed(INPUT_VERB.ACCEPT)
{
	if array_length(level) > 1
	{
		if screen == 0 {screen = 1}
		else
		{
			if skillPoints <= 0
			{
				saveNewStats();
				
				currentStat = 0;
				skillPoints = skillPointsMax;
				if array_length(level) >= 2
				{
					array_delete(level,0,1);
					array_delete(stats,0,1);
					array_delete(baseStats,0,1);
				}
			}
		}
	}
	else
	{
		transition(room, sqBattleEnd, sqFadeIn, true);
	}
}

if array_length(level) > 0 
{
	currentPartyMember = array_get_index(PARTY,level[0]);
	levelUpControls() 
};
