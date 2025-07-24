
//flavorText
//textSoundLUT()

global.topics = {};

	global.topics[$ "placeholder"] = 
	[
		TEXT("an extremely interesting placeholder text box with very funny placeholder text"),
	]
	
	global.topics[$ "Example"] = 
	[
		
		TEXT("This is a garbage can"),
		TEXT("it is sooooooooooooooooooooooooooooooooooo stinky"),
		TEXT("[wave]smelly as shit"),
		TEXT("[sCharIdle,3]"),
		TEXT("[c_red]ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ")
	];
	
	global.topics[$ "enemy room"] = 
	[
		TEXT("Welcome to enemy room.\nBeware of enemies."),
	];
	
	global.topics[$ "sand man"] = 
	[
		TEXT("Yo I'm a frickin pile a sand."),
		TEXT("..."),
		TEXT("Fight me or somethin!")
	];

	global.topics[$ "Gwen"] = 
	[
		SPEAKER("Nils", sPortNils),
		TEXT("Hi Gwen"),
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("I hate you so fucking much"),
		TEXT("[wave][sCharIdle,3][sCharIdle,3][sCharIdle,3][sCharIdle,3][sCharIdle,3][sCharIdle,3][sCharIdle,3]"),
	];
	
	function scribRumble()
	{ global.cam.shake_screen(20,10); oSFX.textSFX = snHit7 }
	
	scribble_typists_add_event("rumble", scribRumble);
	global.topics[$ "Charlie Choices"] = 
	[
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("Nils I'm gonna give you [rumble]TWO options."),
		CHOICE("Woudl you rather see One Charlie\n or Two Charlies",
			OPTION("One", "Chose One Charlie"),
			OPTION("Two", "Chose Two Charlie"),
			OPTION("NONE", "Chose No Charlie"))
	];
	

	global.topics[$ "Chose One Charlie"] = 
	[
		SPEAKER("Nils", sPortNils,, PORT_SIDE.L,),
		TEXT("I pick One Charlie."),
		SPEAKER(""),
		TEXT("[sCharIdle,3]!"),
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("You have chosen ONE Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose Two Charlie"] = 
	[
		SPEAKER("Nils", sPortNils,, PORT_SIDE.L),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhh..."),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh..."),
		TEXT("I pick Two Charlie."),
		SPEAKER(""),
		TEXT("[sCharIdle,3][sCharIdle,3]!!"),
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("You have chosen TWO Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose No Charlie"] = 
	[
		SPEAKER(""),
		TEXT(""),
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("That was stupid, Pick again"),
		GOTO("Charlie Choices")
	];
	
	global.topics[$ "Chose Wisely"] = 
	[
		TEXT("Good choice.")
	];
