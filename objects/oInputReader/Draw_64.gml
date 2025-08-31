/// @


if global.inputDisplay and room != rMenu
{
	alpha = lerp(alpha,alphaTarg,0.1);

	for (var i = 0; i < array_length(inputs); i++ )
	{
		var scribb = scribble(inputs[i])
			.starting_format("fSmartOut",c_white)
			.align(fa_right,fa_top)
			.blend(c_white,alpha - (i * 0.15))
	
		scribb.draw(drawX,drawY + (i*lineHeight))
	}
}