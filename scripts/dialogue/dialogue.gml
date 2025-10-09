
//flavorText
//textSoundLUT()
global.topics = {};

function initDialogue()
{
	global.topics[$ "placeholder"] = 
	[
		TEXT("an extremely interesting placeholder text box with very funny placeholder text"),
	]

	global.topics[$ "menuHelp"] = 
	[
		TEXT("OVERWORLD:"nl nl"Move with the arrow keys"nl"Z - interact, X - run, C - open menu." nl "Save your game at smelly objects, or in the pause menu."),
		TEXT("TEXTBOXES:"nl nl "Z -" nl "..." nl "...It's like Deltarune..."),
		TEXT("COMBAT:"nl nl "A/S/D - Light/Med/Heavy attacks. Heavier attacks are slower/stronger" nl "Tap towards incoming shot to parry, or hold away from shots to defend." ),
	]

	global.topics[$ "theBigWet"] = 
	[
		TEXT("Wait!!!"),
		TEXT("You can't go down there! Look at that wet floor sign!"),
		SPEAKER(global.playerName,sPortNils),
		TEXT("Oh yeah, I'd better not. Lookin pretty wet!")
	]

	#region stupid testing shit

	global.topics[$ "enemy room"] = 
	[
		TEXT("Welcome to enemy room.\nBeware of enemies."),
	];
	
	global.topics[$ "GwenTest"] = 
	[
		SPEAKER(global.playerName, sPortMatt),
		SPEAKER(global.playerName, sPortChar),
		SPEAKER(global.playerName, sPortNils),
		TEXT("Hi Gwen"),
		SPEAKER("Gwen", sPortGwen,, PORT_SIDE.R),
		TEXT("I hate you so fucking much"),
		SPEAKER("Matthew", sPortMatt),
		TEXT("Hello I am the green man wow"),
		SPEAKER("Charlie", sPortChar),
		TEXT("and I am child [sCharIdle,3]"),
	];
	
	global.topics[$ "Charlie Choices"] = 
	[
		SPEAKER("Gwen", sPortGwen, 2, PORT_SIDE.R),
		TEXT("Nils I'm gonna give you [rumble]TWO options."),
		CHOICE("Woudl you rather see One Charlie\n or Two Charlies",
			OPTION("One", "Chose One Charlie"),
			OPTION("Two", "Chose Two Charlie"),
			OPTION("NONE", "Chose No Charlie"))
	];
	

	global.topics[$ "Chose One Charlie"] = 
	[
		SPEAKER(global.playerName, sPortNils,, PORT_SIDE.L,),
		TEXT("I pick One Charlie."),
		SPEAKER(""),
		TEXT("[sCharIdle,3]!"),
		SPEAKER("Gwen", sPortGwen,2, PORT_SIDE.R),
		TEXT("You have chosen ONE Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose Two Charlie"] = 
	[
		SPEAKER(global.playerName, sPortNils,1, PORT_SIDE.L),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhh..."),
		SPEAKER(global.playerName, sPortNils,2, PORT_SIDE.L),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh..."),
		SPEAKER(global.playerName, sPortNils,0, PORT_SIDE.L),
		TEXT("I pick Two Charlie."),
		SPEAKER(""),
		TEXT("[sCharIdle,3][sCharIdle,3]!!"),
		SPEAKER("Gwen", sPortGwen,0, PORT_SIDE.R),
		TEXT("..."),
		SPEAKER("Gwen", sPortGwen,2, PORT_SIDE.R),
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
	
	#endregion

	#region CUTSCENE DIALOGUES

		global.topics[$ "cutBathroomMirror"] = 
		[
			SPEAKER(global.playerName, sPortNils),
			TEXT("Is that what I look like??"nl"I'm a chubby little skeleton guy??"),
			SPEAKER(),
			TEXT("//Oh? Were you not always this way?"),
			SPEAKER(global.playerName, sPortNils),
			TEXT("... I- I don't know... I don't remember..."nl"I have such foggy memories, but... I'm sure I wasn't always this..."),
			SPEAKER(global.playerName, sPortNils,4),
			TEXT("Why don't I remember anything important??"nl"All I can remember is useless shit like the capital of Canada!!"nl"And where the fuck am I anyway?? Does Ottawa even still exist???"),
			SPEAKER(),
			TEXT("//Perhaps we can find someone who will help us..."nl"//For now it may be best to try and calm yourself."),
			TEXT("//Maybe take some toilet time to catch your breath."),
			SPEAKER(global.playerName, sPortNils,1),
			TEXT("Yeah okay... worth a shot."nl"I mean who even knows if I can shit, I doubt I have internal organs anyway..."),
		];

	#endregion

}