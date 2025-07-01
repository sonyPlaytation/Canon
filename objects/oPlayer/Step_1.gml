/// @

if cFollow and Charlie == noone
{
	Charlie = instance_create_depth(x,y,depth,oCharlie)
	Charlie.followDist = cDist;
}

if mFollow and Matthew == noone
{
	Matthew = instance_create_depth(x,y,depth,oMatthew)
	Matthew.followDist = mDist;
}