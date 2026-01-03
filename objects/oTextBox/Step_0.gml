/// @

for (var i = 0; i < array_length(sound); i++) {
	if doSquish == squishEvery and audio_is_playing(sound[i]) {speakerSquish = 1.05;}
    
}

if doSquish >= squishEvery {doSquish = 0}
doSquish++

speakerSquish = lerp(speakerSquish,1,0.15)

var confirm = InputPressed(INPUT_VERB.ACCEPT);
var skipLess = InputPressed(INPUT_VERB.RUN);
var skip = InputCheck(INPUT_VERB.SKIP)

progress = min(progress + spd, length);

if skip and typist.get_state() >= 0.01 {
	
	if optCount == 0 { next(); } else typist.skip();
} else if typist.get_state() >= 1 {
	
	if optCount > 0
	{ 
		var left = InputPressed(INPUT_VERB.LEFT);
		var right = InputPressed(INPUT_VERB.RIGHT); 
		var change = (right - left);
		
		if change != 0
		{
			currentOption += change;
			
			if currentOption < 0
				{ currentOption = optCount -1; }
			else if currentOption >= optCount
				{ currentOption = 0; }
		}
		
		if confirm
		{
			var option = options[currentOption];
			options = [];
			optCount = 0;
			option.act(id);
		}
	}
	else if confirm {next()};
	
} else if skipLess {
	
	typist.skip();
}