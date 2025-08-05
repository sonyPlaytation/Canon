
event_inherited()

trail_init()

inputX = 0;
inputY = 0;
dir = 0;
prevDir = dir;
hsp = 0;
vsp = 0;

parry = 0;
flash = 0
hit = 0;

dist = TILE_SIZE*2;
currDist = 0;

homeX = xstart;
homeY = ystart;

parryTimer = 0;
parryWindow = 12;
parryDir = 0;
parryCooldown = 60;
parryCooldownCurrent = 0;

defenseHitbox = instance_create_depth(x,y,depth+10,oBattleDefenseHitbox)