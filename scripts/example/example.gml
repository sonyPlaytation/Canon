
function hurt(){}
function poison(){}
function heal(){}
function fullheal(){}
function makeinvincible(){}

function rngDoRolls(){
    
    // Press "R" to reroll your number! 
    randomize(); // gotta call this in order to actually get random rolls
    var attemptsAllowed = 3 
    var functions         = [poison]
    var rareFunctions     = [fullheal, makeinvincible]
    var rewards = []; // we will be putting all the rolls into this array
    var rngWeight, rngRoll;
    
    for (var i = 0; i < attemptsAllowed; i++) {
        
        rngWeight     = irandom_range(1, 100) // roll value
        if(rngWeight >=1 && rngWeight <= 75) // 75% chance, Roll to select Commons
        {
			if array_length(functions) == 0 continue;
            rngRoll = irandom(array_length(functions)-1) // can roll 0 or 1, arrays start at index 0
            rewards[i] = functions[rngRoll]; // adds function to the rewards array in the slot of the current loop iteration
            array_delete(functions,rngRoll,1) // deletes the function from the potential rewards array so you cant roll it multiple times in one go
        }
        else if(rngWeight >=76 && rngWeight <= 100) // 25% chance, Roll to select Commons
        {
			if array_length(rareFunctions) == 0 continue;
            rngRoll = irandom(array_length(rareFunctions)-1) // can only roll fullHeal or makeInvincible
            rewards[i] = rareFunctions[rngRoll];
            array_delete(rareFunctions,rngRoll,1)
        }
		show_message(rewards[i])
    }
    
    return rewards; 
    // i just did this part because i made it into a function. 
    //this way when you call rngDoRolls you can get the rewards back in the form of an array
}
//rngDoRolls()