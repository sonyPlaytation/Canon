
color = c_white;

options = 
{
	startGame : 
	{
		label : "Debug Start",
		func : function() { transition(room_next(room),sqFadeOut,sqFadeIn,,,,,true) }
	},
	
	newGame : 
	{
		label : "New Game",
		func : function() { deleteSave() initFlags(); transition(rOffice,sqFadeOut,sqFadeIn,,,,,true) }
	},
	
	loadSavefile : 
	{
		label : "Load Game",
		func :  function() { loadGame(true)  transition(room_next(room),sqFadeOut,sqFadeIn,,,,,true) }
	},
	
	help : 
	{
		label : "Help",
		func :  function() { startDialogue("menuHelp") }
	},
	
	wipeSave : 
	{
		label : "Wipe Save",
		func :  function() { deleteSave() }
	},
}

