

if instance_exists (oBattleDefenseManager)
{
	if oBattleDefenseManager.parry > 0 {exit}

	x += lengthdir_x(spd,dir)
	y += lengthdir_y(spd,dir)
}

if pleaseWrapItUp
{
	spd *= 0.85
	mask_index = sBlank;
	image_xscale *= 0.75;
	image_yscale *= 0.75;
	image_alpha *= 0.75;
	tailW *= 0.75
	
	if image_alpha < 0.05 {instance_destroy();}
} else image_alpha = lerp(image_alpha, 1, 0.1);
