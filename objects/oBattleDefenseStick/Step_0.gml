
inputX = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)
inputY = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP)

currDist = dist;
if inputX == 0 and inputY == 0 {currDist = 0; dir = -1}
else dir = point_direction(0, 0, inputX, inputY);

hsp = lengthdir_x(currDist,dir);
vsp = lengthdir_y(currDist,dir);	

if dir != 0 {parryDir = dir}

x = xstart + hsp;
y = ystart + vsp;

defenseHitbox.hsp = lengthdir_x(currDist,dir-180);
defenseHitbox.vsp = lengthdir_y(currDist,dir-180);	
defenseHitbox.image_alpha = currDist * image_alpha

if parryTimer > 0 {parryTimer--;}
if parryCooldownCurrent > 0 {parryCooldownCurrent--;}

if parryTimer == 0 and parryCooldownCurrent == 0 and prevDir == -1 and dir != -1
{
	parryTimer = parryWindow;
	parryCooldownCurrent = parryCooldown;
}

prevDir = dir;

if pleaseWrapItUp {image_alpha *= 0.65}