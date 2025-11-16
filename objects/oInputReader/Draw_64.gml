/// @


if global.inputDisplay and room != rMenu
{
	alpha = lerp(alpha,alphaTarg,0.1);
	drawYOffset = lerp(drawYOffset,drawYOffsetTarg,0.1);
	
	for (var i = 0; i < array_length(inputs); i++ )
	{
		draw_set_text(numFont,c_white,fa_right,fa_top)
		
		draw_set_alpha(alpha - (i / linesMax))
		var line = inputs[i]
		
        // Frames
		var LineY = drawY+drawYOffset + (i*lineHeight)
		draw_text(drawX+4,LineY,line[0])
		
        // Directions
		draw_set_halign(fa_center)
		draw_sprite(sInputArrows,line[1], drawX+9,LineY)
		
        // Buttons
		var buttonsPressed = 0;
		for (var j = 0; j < array_length(line[2]); j++)
		{
			draw_set_halign(fa_left)
			
			var button = line[2][j];
			if button != 0 
			{
				buttonsPressed++;
				draw_sprite(inputSprites[j],button,drawX+12 + (12*buttonsPressed),LineY)
			}
		}
	}
	
	draw_set_alpha(1)
}