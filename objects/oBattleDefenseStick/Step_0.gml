
inputX = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)
inputY = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP)

currDist = dist;
if inputX == 0 and inputY == 0 {currDist = 0; dir = -1}
else dir = point_direction(0, 0, inputX, inputY);

hsp = lengthdir_x(currDist,dir);
vsp = lengthdir_y(currDist,dir);	

if dir != 0 {parryDir = dir}

x = lerp(x,xstart + hsp,0.75);
y = lerp(y,ystart + vsp,0.75);

defenseHitbox.hsp = lengthdir_x(currDist,dir-180);
defenseHitbox.vsp = lengthdir_y(currDist,dir-180);	

if currDist == 0 and !pleaseWrapItUp {defenseHitbox.alphaTarg = 0.2} 
else {defenseHitbox.image_alpha = image_alpha}

if parryTimer > 0 {parryTimer--;}
if parryCooldownCurrent > 0 {parryCooldownCurrent--;}

if parryTimer == 0 and parryCooldownCurrent == 0 and prevDir == -1 and dir != -1
{
	parryTimer = parryWindow;
	parryCooldownCurrent = parryCooldown;
}

prevDir = dir;

if pleaseWrapItUp {image_alpha *= 0.65}