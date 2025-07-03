function Menu(_x, _y, _options, _desc = -1, _w = undefined, _h = undefined, _selectable = true)
{

	with (instance_create_depth(_x,_y,-99999,oMenu))
	{
		options = _options;
		desc = _desc;
		var optionsCount = array_length(_options);
		visibleOptionsMax = optionsCount;
		
		xmargin = 12;
		ymargin = 12;
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
}

function subMenu(_options)
{
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function menuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}