if instance_exists(oSandstorm) and place_meeting(x,y,oPlayer){
	distFromTop = oPlayer.y - bbox_top
	distFromBtm = bbox_bottom - oPlayer.y 
	if distFromBtm > 0 {oSandstorm.alpha = lerp(0,1,(height/distFromBtm)/10)}
}