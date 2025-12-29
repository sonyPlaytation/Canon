/// @

sprite_index = sprites.idle;

show_debug_message(name)
selfCenter = y;
z = 0;

dieText = ds_list_create()

ds_list_add(dieText, "{0} bites the big one.")
ds_list_add(dieText, "{0} is in a better place.")
ds_list_add(dieText, "{0} fucking DIED.")
ds_list_add(dieText, "{0} died BADLY.")
ds_list_add(dieText, "{0} is sleeping peacefully.")
ds_list_add(dieText, "{0} might be playing dead. MIGHT.")
ds_list_add(dieText, "Today was {0}'s last.")
ds_list_add(dieText, "{0} meets a gruesome end.")
ds_list_add(dieText, "{0} couldn't hack it.")
ds_list_add(dieText, "{0} will not return in Canon 2.")

myDied = "";
alreadyDead = false

parry = 0;
flash = 0;
hit = 0;
flashCol = c_white;
acting = false;

curve = animcurve_get_channel(acBattleSlideIn,"curve1");
percent = 0;
percentTarg = -1;
forward = false;

StatusEffectResolveOrder = [
    "debuffs",
    "buffs",
    "statuses"
]

runStatus = function(){
    
    array_foreach(StatusEffectResolveOrder, function(element, index){
        for (var i = 0; i < array_length(effects[$ element]); i++) {
    	
            var status = effects[$ element][i]
            
            if status == 0 exit;
            
            status.statFunc(self);
            
            if status.life <= 0 {
                status.statEnd(self)
                array_delete(effects[$ element],i,1);
            }   
        }
    })
}

drawStatus = function(){
    
    array_foreach(StatusEffectResolveOrder, function(element, index){
        for (var i = 0; i < array_length(effects[$ element]); i++) {
    	
            var status = effects[$ element][i]
            
            if status == 0 exit;
            
            status.drawEffect(id);
        }
    })
}