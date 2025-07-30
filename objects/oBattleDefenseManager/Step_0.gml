
if parry > 0 {parry--;}
stick.flash = parry;

if pleaseWrapItUp
{
	lerpSpeed = 0.33
	alphaTarg = 0;
	radiusTarg = 0;
	
	if alpha == 0 
	{
		instance_destroy()
		instance_destroy(stick)	
	}
}