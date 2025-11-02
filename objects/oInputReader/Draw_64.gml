/// @


if global.inputDisplay and room != rMenu
{
	alpha = lerp(alpha,alphaTarg,0.1);
	
	for (var i = 0; i < array_length(inputs); i++ )
	{
		draw_set_text(fSmart,c_black,fa_right,fa_middle)
		
		draw_set_alpha(alpha - (i * 0.15))
		var line = inputs[i]
		
        // Frames
		var LineY = drawY + (i*lineHeight)
        
        draw_text(drawX+1,LineY,line[0])
        draw_text(drawX,LineY+1,line[0])
        draw_text(drawX-1,LineY,line[0])
        draw_text(drawX,LineY-1,line[0])
        
        draw_set_color(c_white)
		draw_text(drawX,LineY,line[0])
		
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