
// flavorText
// textSoundLUT()
global.topics = {};

function initDialogueAct1()
{
    
	global.topics[$ "placeholder"] = 
	[
		TEXT("// an extremely interesting placeholder text box with very funny placeholder text"),
	]

	global.topics[$ "menuHelp"] = 
	[
		TEXT("OVERWORLD:"nl nl"Move with the arrow keys"nl"Z - interact, X - run, C - open menu." nl "Save your game at smelly objects, or in the pause menu."),
		TEXT("TEXTBOXES:"nl nl "Z -" nl "..." nl "...It's like Deltarune..."),
		TEXT("COMBAT:"nl nl "A/S/D - Light/Med/Heavy 'normals'. Heavier attacks are slower/stronger" nl "Tap towards incoming shot to parry, or hold away from shots to defend." ),
		TEXT("COMBAT CONT.:"nl "'Specials' are basically your spells, and can be done during the normals phase by performing their associated fighting game style motion inputs." nl "Some inputs can be seen on the Specials' info card in the menu, but they aren't all implemented yet." ),
		TEXT("COMBAT CONT 2.:"nl $"Nils - {convertMoveString("236P")}: Devil's Gun | {convertMoveString("41236P")}: Fan Hammer"nl $"Charlie - {convertMoveString("236P")} Heal | {convertMoveString("623P")} - Heal Many | {convertMoveString("623623P")} - Revive"nl $"Matthew - {convertMoveString("623H")}: Rising Upper" ),
	]
    
    global.topics[$ "menuReadme"] = 
	[
		TEXT("Developer Note: Jan 5, 2026"),
		TEXT("Thank you so much for deciding to play Canon!"),
		TEXT("This idea for the project dates back to my second year of high school, but this current iteration of development started in July of 2025."),
		TEXT("I did all the art and music for this myself, and a majority of the code (not including libraries) is my own as well (with much guidance from the GM Discord)."nl"Canon's main mechanical gimmick is just 'what if turn based rpg but has street fighter combat' in a similar ratio that UT/DR have danmaku inspiration and mechanics."),
		TEXT("In terms of purely mechanical completion I'd estimate that the project is nearing the halfway point, but the content is where the real turmoil lies."nl"I have always joked that the game would take me a decade to put out, but I'm coming up on year 9 of its inception so I'm not laughing much anymore."),
		TEXT("This game is my lifes work. I don't care about financial success, or critical reception, I just want to tell my story in whatever shape it ends up being at release."nl"Nearly everything I do these days is in pursuit of finishing this. If you've seen the movie Synecdoche New York, it is unfortunately much like that"),
		TEXT("Canon is made in Gamemaker, I jot down quick ideas in a semi-private discord server, I flesh out lore and connective tissue in an Obsidian.md vault, and I track progress on a ClickUp board where I do biweekly sprints by myself."),
		TEXT("I am in the IT field in college as a means to an end to finish this game. It is literally my number one priority, and if nothing else, I want the player to feel that."),
		TEXT("Thank you so much for deciding to play Canon."nl"Truly.")
		
	]

	global.topics[$ "theBigWet"] = 
	[
		TEXT("// Wait!!!"),
		TEXT("// You can't go down there! Look at that wet floor sign!"),
		SPEAKER(FLAGS.playerName,sPortNils),
		TEXT("Oh yeah, I'd better not. Lookin pretty wet!")
	]

	#region stupid testing shit

	global.topics[$ "enemy room"] = 
	[
		TEXT("Welcome to enemy room.\nBeware of enemies."),
	];
	
	global.topics[$ "GwenTest"] = 
	[
		SPEAKER(FLAGS.playerName, sPortMatt),
		SPEAKER(FLAGS.playerName, sPortChar),
		SPEAKER(FLAGS.playerName, sPortNils),
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
		SPEAKER(FLAGS.playerName, sPortNils,, PORT_SIDE.L,),
		TEXT("I pick One Charlie."),
		SPEAKER(""),
		TEXT("[sCharIdle,3]!"),
		SPEAKER("Gwen", sPortGwen,2, PORT_SIDE.R),
		TEXT("You have chosen ONE Charlie..."),
		GOTO("Chose Wisely")
	];
	
	global.topics[$ "Chose Two Charlie"] = 
	[
		SPEAKER(FLAGS.playerName, sPortNils,1, PORT_SIDE.L),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhh..."),
		SPEAKER(FLAGS.playerName, sPortNils,2, PORT_SIDE.L),
		TEXT("Uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh..."),
		SPEAKER(FLAGS.playerName, sPortNils,0, PORT_SIDE.L),
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
			SPEAKER(FLAGS.playerName, sPortNils),
			TEXT("Is that what I look like??"nl"I'm a chubby little skeleton guy? Since when??"),
			SPEAKER(),
			TEXT("// Oh? Were you not always this way?"),
			SPEAKER(FLAGS.playerName, sPortNils),
			TEXT("... I- I don't know... I don't remember..."nl"I have such foggy memories, but... I'm sure I wasn't always this..."),
			SPEAKER(FLAGS.playerName, sPortNils,4),
			TEXT("Why don't I remember anything important??"nl"All I can remember is useless shit like the capital of Canada!!"nl"And where the fuck am I anyway?? Does Ottawa even still exist???"),
			SPEAKER(),
			TEXT("// Perhaps we can find someone who can help you remember more about yourself..."nl"// Though for now it may be best to try and calm yourself."),
			TEXT("// Why not take some toilet time to catch your breath?"),
			SPEAKER(FLAGS.playerName, sPortNils,1),
			TEXT("Yeah okay... worth a shot I guess."nl"I mean who even knows if I can shit, I doubt I have internal organs anyway..."),
		];
		
		global.topics[$ "cutWakeUpOffice"] = 
		[
			SPEAKER(FLAGS.playerName,sPortNils,1),
			TEXT("Ugh Jesus, my head... I really overslept..."nl"What time is it?"),
			SPEAKER(),
			TEXT("// Suddenly you notice the state of the room."),
			TEXT("// This may just be the cleanest room ever."nl"// The walls are a crisp eggshell, the floor boards look and feel brand new, and the chair you're in feels straight from the factory."),
			TEXT("// For some reason you feel disturbed."),
			SPEAKER(FLAGS.playerName,sPortNils,2),
			TEXT("Better question is..."), 
			SPEAKER(FLAGS.playerName,sPortNils,3),
			TEXT("Where the hell am I??"), 
		]

	#endregion

}