

//encounterEXP = 0
//killsList = []
//winQuote = "poopyhead"

depth = oBattle.depth-200

//myDoc = instance_create_depth(x,y,depth,yui_document,
//{
//	yui_file : "YUI/battleResults.yui",
//	data_context : oBattleResults
//})

pad1 = TILE_SIZE
pad2 = TILE_SIZE/2 // 12
pad3 = TILE_SIZE/3 // 8
pad4 = TILE_SIZE/4 // 6

screen = 0

level = []
skillPointsMax = 6
skillPoints = skillPointsMax;
stats = []
baseStats = []
currentStat = 0;

lFrames = 0;
currentPartyMember = 0;

holdFrames = 20;
holdMod = 5

guyToLevel = 0;

array_foreach(PARTY,function(_element,_index)
{
	addEXP(encounterEXP,_element)
})

bgAlpha = 0;
bgAlphaTarg = 0.65;
bgCol = c_black;

oInputReader.alphaTarg = 0

padding = pad1 * 2
margin = pad1
w = GAME_W - padding*2
h = 0;
hTarg = GAME_H - padding;
hSpeed = 12

_x = global.cam.get_x()
_y = global.cam.get_y()
x = global.cam.get_x()+padding
y = global.cam.get_y()+TILE_SIZE

scrWhalf = _x + (GAME_W/2)
scrHhalf = _y + (GAME_H/2)

// party boxes
boxX = x + pad3
boxY = y + (pad1*8)
boxW = pad1*7
boxH = pad1*4.5
boxPadding = pad1*5

// quote
winquoteHead = PARTY[irandom(array_length(PARTY)-1)].sprites.head 
quoteX = x + pad2
quoteY = boxY - (pad3*4)
quoteW = w - pad1
quoteH = pad1;

levelUpControls = function()
{
	
	if InputCheck(INPUT_VERB.LEFT)	{lFrames++}else lFrames = 0;
	if InputCheck(INPUT_VERB.RIGHT) {rFrames++}else rFrames = 0;
	if InputCheck(INPUT_VERB.UP)	{uFrames++}else uFrames = 0;
	if InputCheck(INPUT_VERB.DOWN)	{dFrames++}else dFrames = 0;
	
	var l = InputPressed(INPUT_VERB.LEFT)	or (lFrames > holdFrames and lFrames mod 5 == 0) 
	var r = InputPressed(INPUT_VERB.RIGHT)	or (rFrames > holdFrames and rFrames mod 5 == 0) 
	var u = InputPressed(INPUT_VERB.UP)		or (uFrames > holdFrames and uFrames mod 5 == 0) 
	var d = InputPressed(INPUT_VERB.DOWN)	or (dFrames > holdFrames and dFrames mod 5 == 0) 

	
	if currentStat < array_length(stats[guyToLevel])-1 and d {currentStat++}
	if currentStat > 0 and u {currentStat--}	
	
	if stats[guyToLevel][currentStat] > baseStats[guyToLevel][currentStat] and l
	{
		stats[guyToLevel][currentStat]--
		skillPoints++
	}
	else if skillPoints > 0 and r
	{
		stats[guyToLevel][currentStat]++
		skillPoints--
	}
}

saveNewStats = function()
{
	var guy = level[guyToLevel].stats
	
	guy[$ "str"] =	 stats[guyToLevel][0]
	guy[$ "dex"] = 	 stats[guyToLevel][1]
	guy[$ "exStr"] = stats[guyToLevel][2]
	guy[$ "exDef"] = stats[guyToLevel][3]
	guy[$ "int"] = 	 stats[guyToLevel][4]
	guy[$ "spd"] = 	 stats[guyToLevel][5]
	guy[$ "cha"] = 	 stats[guyToLevel][6]
	guy[$ "luk"] = 	 stats[guyToLevel][7]
}