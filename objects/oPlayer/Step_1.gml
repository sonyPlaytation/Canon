/// @

if cFollow and Charlie == noone
{
	Charlie = instance_create_depth(x - lengthdir_x(cDist*3,facing*90),y - lengthdir_y(cDist*3,facing*90),depth,oCharlie)
	Charlie.followDist = cDist;
}

if mFollow and Matthew == noone
{
	Matthew = instance_create_depth(x - lengthdir_x(mDist*3,facing*90),y - lengthdir_y(mDist*3,facing*90),depth,oMatthew)
	Matthew.followDist = mDist;
}