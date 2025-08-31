
startGame = function()
{
	room_goto_next()
}

loadSavefile = function()
{
	transition(loadGame(),sqFadeOut,sqFadeIn,,,,,true)
}

color = c_white;

this = [startGame,loadSavefile]

switch (doThis)
{
	case 0: label = "start game" break;
	case 1: label = "load save" break;
}

image_xscale = 8;
image_yscale = 3;