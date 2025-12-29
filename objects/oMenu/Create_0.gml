/// @

//Menu()



//depth = oBattle.depth-10
hover = 0;
active = true;
subMenuLevel = 0;
currentMenu = "Menu";
prevMenus = [];

x = -120
xTarg = 36;
lerpSpd = 0.25;
y = 0
menuGap = 6

selectY = y;
destroyMenu = false
//options = {}

visibleOptionsMax = 5

lineHeight = 19;
height = 0
heightFull = 0
xmargin = 12;
ymargin = 8

canDestroy = false;
alarm[1] = 10;

alpha = 0;
alphaTarg = 0.5;

goBack = new IMenuable("Back").setFunc(function(){doGoBack(id)});
user = NILS
//options[$ "Menu"] = [
    //
    //MENU("Normals")  .setFunc(global.actionLibrary.normals),
    //MENU("Specials") .setFunc(global.actionLibrary.normals),
    //MENU("Items") .setFunc(global.actionLibrary.normals).setAllowed(false),
    //
//
    //
    //
//]

menuControls()