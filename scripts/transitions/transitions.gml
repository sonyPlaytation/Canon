
global.enemiesKilled = {}

global.midTransition = false;
global.roomTarget = -1;

global.transitionX = 0;
global.transitionY = 0;

global.playerReturnX = -1;
global.playerReturnY = -1;

global.moveFacing = 0;
global.currentTransition = noone
global.defaultRoomPosition = false

function createTransition(_type)
{
	if layer_exists("transition") layer_destroy("transition");
	var _layer = layer_create(-9999, "transition");
	global.currentTransition = layer_sequence_create(_layer,global.cam.get_x()+(GAME_W/2),global.cam.get_y()+(GAME_H/2),_type);
}

//function transition(_roomTarget, _typeOut, _typeIn, _fight = false, _x = 0, _y = 0, face = 0, _defaultPos = false)
//{
//	if !global.midTransition
//	{
//		global.defaultRoomPosition = _defaultPos;
		
//		if !_fight
//		{
//			global.transitionX = _x;
//			global.transitionY = _y;
//			if face > -1 {global.moveFacing = face;} else face = oPlayer.facing;
//			global.roomTarget = _roomTarget;
//		}
		
//		global.midTransition = true;
//		createTransition(_typeOut);
		
//		if !_fight
//		{
//			layer_set_target_room(_roomTarget);
//			createTransition(_typeIn);
//			layer_reset_target_room();
//		}
		
//		return true;
//	} else return false;
//}

function transition(_roomTarget, _typeOut, _typeIn, _fight = false, _x = 0, _y = 0, face = 0, _defaultPos = false)
{

	if !global.midTransition
	{
		global.canPause = false;
		global.defaultRoomPosition = _defaultPos;
		
		global.transitionX = _x;
		global.transitionY = _y;
		if face > -1 {global.moveFacing = face;} else global.moveFacing = oPlayer.facing;

		if instance_exists(oPlayer)
		{
			global.playerReturnX = oPlayer.x;
			global.playerReturnY = oPlayer.y;
		}
		
		global.roomTarget = _roomTarget;
		global.midTransition = true;
		createTransition(_typeOut);

		layer_set_target_room(_roomTarget);
		createTransition(_typeIn);
		layer_reset_target_room();	
		
		return true;
	} else return false;
}

function returnToPrevRoom(_typeOut = sqBattleEnd, _typeIn = sqFadeIn)
{
	global.defaultRoomPosition = false;
	
	if !global.midTransition
	{
		global.transitionX = global.playerReturnX;
		global.transitionY = global.playerReturnY;
		
		global.roomTarget = oRoomCapture.returnRoom;
		global.midTransition = true;
		createTransition(_typeOut);

		layer_set_target_room(global.roomTarget);
		createTransition(_typeIn);
		layer_reset_target_room();	
		
		return true;
	} else return false;
}

function transitionChangeRoom()
{	
	//oCamera.drawNothing = true
	room_goto(global.roomTarget);	
}

function transitionEnd()
{	
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	global.canPause = true;
}

function cameraOff()
{ oCamera.drawNothing = true }

function cameraOn()
{ oCamera.drawNothing = false }

function cameraToggle()
{ oCamera.drawNothing = !oCamera.drawNothing }