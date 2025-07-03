
global.topics = {};


	global.topics[$ "Example"] = 
	[
		
		TEXT("This is a garbage can"),
		TEXT("it is sooooooooooooooooooooooooooooooooooo stinky"),
		TEXT("[wave]smelly as shit"),
		TEXT("[sCharlie]"),
		TEXT("[c_red]ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ")
	];

	global.topics[$ "Gwen"] = 
	[
		SPEAKER("Nils", sPortNils),
		TEXT("Hi Gwen"),
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("I hate you so fucking much"),
		TEXT("[wave][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie][sCharlie]"),
	];
	
	global.topics[$ "Charlie Choices"] = 
	[
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("Nils I'm gonna give you two options."),
		CHOICE("Woudl you rather see One Charlie\n or Two Charlies",
			OPTION("One", "Chose One Charlie"),
			OPTION("Two", "Chose Two Charlie"),
			OPTION("NONE", "Chose No Charlie"))
	];
	
	global.topics[$ "Chose One Charlie"] = 
	[
		SPEAKER(""),
		TEXT("[sCharlie]!"),
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("You have chosen ONE Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose Two Charlie"] = 
	[
		SPEAKER(""),
		TEXT("[sCharlie][sCharlie]!!"),
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("You have chosen TWO Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose No Charlie"] = 
	[
		SPEAKER(""),
		TEXT(""),
		SPEAKER("Gwen", sPortGwen, PORT_SIDE.R),
		TEXT("That was stupid, Pick again"),
		GOTO("Charlie Choices")
	];
	
	global.topics[$ "Chose Wisely"] = 
	[
		TEXT("Good choice.")
	];
