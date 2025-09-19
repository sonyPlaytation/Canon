
#macro BATTLE battleText

function Menu(_x, _y, _options, _desc = -1, _w = undefined, _h = undefined, _selectable = true)
{
	var menu = (instance_create_depth(_x,_y,-9999,oMenu))
	with menu
	{
		options = _options;
		desc = _desc;
		var optionsCount = array_length(_options);
		visibleOptionsMax = 6;
		
		xmargin = 12;
		ymargin = 8;
		draw_set_font(fSmall);
		lineHeight = 16;
		
		if _w == undefined
		{
			width = 1;
			if desc != -1 width = max(width, string_width(_desc))
			for (var i = 0; i < optionsCount; i++)
			{
				width = max(width, string_width(_options[i][0]));	
			}
			widthFull = width + (xmargin * 2);
		}else widthFull = _w;
		
		if _h == undefined
		{
			height = lineHeight * (optionsCount + (desc != -1));
			heightFull = height + (ymargin * 2);
		}
		else
		{
			heightFull = _h	
			//scrolling
			if (lineHeight * (optionsCount + (desc != 1))) > _h - (ymargin/2)
			{
				scrolling = true;
				visibleOptionsMax = (_h - ymargin*2) div lineHeight;
			}
		}
	}
	return menu;
}

function subMenu(_options, _desc = -1)
{
	active = false
	
	var menu = (instance_create_depth(x + sprite_get_width(sBattleOptionHeader),selectY,-9989,oSubmenu))
	with menu
	{
		owner = other;
		options = _options;
		desc = _desc;
		var optionsCount = array_length(_options);
		visibleOptionsMax = 6;
		
		xmargin = 12;
		ymargin = 8;
		draw_set_font(fSmall);
		lineHeight = 19;
		height = lineHeight * (visibleOptionsMax + 1 + (desc != -1));
		heightFull = height + (ymargin * 2);

	}
	return menu;
	
}

function menuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function submenuGoBack()
{
	destroyMenu = true;
}

function menuSelectAction(_user, _action)
{
	with (oMenu) {active = false;}
	
	with oBattle
	{
		if (_action.targetRequired)	
		{
			with cursor
			{
				active			= true 	;
				activeAction	= _action;
				targetAll		= _action.targetAll	;
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser		= _user ;
				
				if _action.targetEnemyByDefault
				{
					targetIndex		= 0;
					targetSide		= oBattle.enemyUnits;
					activeTarget	= oBattle.enemyUnits[targetIndex];
				}
				else
				{
					targetSide = oBattle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return (_element == activeTarget)	
					}
					targetIndex = array_find_index(oBattle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			beginAction(_user,_action,-1)
			with(oMenu) destroyMenu = true;
		}
	}
}

function battleText(_desc, _user = "", _targ = "")
{
	var msg = string_ext(_desc,[_user,_targ]);
	msg = scribble(msg);
	msg.starting_format("fBattle",c_white);
	array_insert(oBattle.btlText, 0, msg)
}

