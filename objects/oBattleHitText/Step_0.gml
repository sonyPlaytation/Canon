/// @

if y >= ystart+1
{
	direction = startDirection;
	speed = speed /2;
}

if speed < 0.25 {alpha -= 0.25}
if alpha <=0 instance_destroy();