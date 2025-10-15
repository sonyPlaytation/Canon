// Inherit the parent event
event_inherited();

hsp = 0;
vsp = 0;
grv = 0;
pop = false

tailW = 10

circle = round(point_direction(x,y,oBattleDefenseStick.x,oBattleDefenseStick.y));
goNow = false
goal = point_direction(x,y,oBattleDefenseStick.homeX,oBattleDefenseStick.homeY)
laps = irandom(1);
alarm[0] = 120;

image_alpha = 0;

trail_init()