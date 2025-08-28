

//encounterEXP = 0
//killsList = []
//winQuote = "poopyhead"


//myDoc = instance_create_depth(x,y,depth,yui_document,
//{
//	yui_file : "YUI/battleResults.yui",
//	data_context : oBattleResults
//})

pad1 = TILE_SIZE
pad2 = TILE_SIZE/2 // 12
pad3 = TILE_SIZE/3 // 8
pad4 = TILE_SIZE/4 // 6

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