/// @
if state != stateInCutscene animate()
if global.pauseEvery
{
	if JustHitEnemyButCanStillMoveALittle > 0 and InputCheckMany([INPUT_VERB.UP,INPUT_VERB.DOWN,INPUT_VERB.LEFT,INPUT_VERB.RIGHT])
	{
		JustHitEnemyButCanStillMoveALittle--;
		
		var xinput = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
		var yinput = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
		facing = point_direction(0, 0, xinput, yinput) div 90
	
		switch (facing)
		{
			case 0:
				if sprite_index != anims.walk.R {image_index = 0}
				sprite_index = anims.walk.R;
			break;
			
			case 1:
				if sprite_index != anims.walk.U {image_index = 0}
				sprite_index = anims.walk.U;
			break;
			
			case 2:
				if sprite_index != anims.walk.L {image_index = 0}
				sprite_index = anims.walk.L;
			break;
			
			case 3:
				if sprite_index != anims.walk.D {image_index = 0}
				sprite_index = anims.walk.D;
			break;
		}
	}
	exit;
}

if hasControl 
{ 
	JustHitEnemyButCanStillMoveALittle = JustHitEnemyButCanStillMoveALittleReset;
	//colls = [oColl,sDashGap,pNPC,tiles];
	state();
}
//else if global.midTransition { move_and_collide(hsp,vsp,colls); }


