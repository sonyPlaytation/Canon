if instance_exists(oSandstorm) and place_meeting(x,y,oPlayer){
	distFromTop = oPlayer.y - bbox_top
	distFromBtm = bbox_bottom - oPlayer.y 
	if distFromBtm > 0 {oSandstorm.fade = false; oSandstorm.alpha = lerp(0,1,(height/distFromBtm)/10)}
} else if instance_exists(oSandstorm) and oPlayer.y < bbox_top {oSandstorm.fade = true}