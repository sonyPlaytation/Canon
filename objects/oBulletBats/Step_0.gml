

if instance_exists (oBattleDefenseManager)
{
    if circle mod 45 == 0 and goNow { 
        if oBattleDefenseManager.parry > 0 {exit}
        x += lengthdir_x(spd,goal)
        y += lengthdir_y(spd,goal)
    }
    else { 
        circle+=2.5
        x = oBattleDefenseStick.homeX + lengthdir_x(max(abs(x-oBattleDefenseStick.homeX),100),circle)    
        y = oBattleDefenseStick.homeY + lengthdir_y(max(abs(y-oBattleDefenseStick.homeY),100),circle)
        goal = point_direction(x,y,oBattleDefenseStick.homeX,oBattleDefenseStick.homeY)
    }
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
