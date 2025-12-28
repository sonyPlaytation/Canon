var myEnemy;

if !instance_exists(enemy) {
    oPlayer.x = oPlayerSpawner.x
    oPlayer.y = oPlayerSpawner.y
    myEnemy = instance_create_depth(x,y,depth,enemy)
    myEnemy.doWander = false
    myEnemy.doChase = false 
}
    
