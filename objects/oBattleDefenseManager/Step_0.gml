
time++

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
		instance_destroy(bulletManager)	
	}
}

if closestGuide 
{
	var shots = []
    
    for (var i = 0; i < instance_number(pEnemyAttack); i++)
    {
        var attack = instance_find(pEnemyAttack,i)
        if attack.canHurt {array_push(shots,attack)}
    }
    
    if array_length(shots) > 0
    {
        array_sort(shots,function(e1,e2){
            return e2.lifetime - e1.lifetime;
        });
        with pEnemyAttack { color = c_white }
        shots[0].color = c_red;
    }
}