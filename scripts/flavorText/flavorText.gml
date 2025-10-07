
#macro FLAGS global.flags
#macro nl +"\n"+

itemFuncs()

global.flags = 
{
	//permanent upgrades
	chargeTackle : false,
	
	//running jokes
	solitaire: 0,
	
	//scenario items
	officeBathroomKey : false
}
//dialogue
//textSoundLUT()
//dialogueFuncs

#region general reusable stuff

global.topics[$ "jammed"] = [TEXT("[snSH2DoorLocked]The lock is [c_yellow]JAMMED[c_white]!\nThis door can't be opened.")]
global.topics[$ "lockedGeneric"] = [TEXT("It's [c_red]LOCKED[c_white].")]
global.topics[$ "unlockedGeneric"] = [TEXT("You unlock the door.")]

global.topics[$ "saveFlies"] = 
[
	TEXT("A group of smelly flies buzz around you, each one chasing anothers smell."nl"They are caught in an unending ouroboruos of stench..."),
	GOTO("save")
	
]

global.topics[$ "save"] = 
[

	CHOICE("Would you like to save your progress?",
		OPTION("Yes","yesToSave"),
		OPTION("No",""))
]

global.topics[$ "yesToSave"] = 
[
	SET(oTextBox,"dialogueResponse", true),
	BEGINSAVE()
]

#endregion

#region rOffice

	global.topics[$ "officePhoto"] = 
	[
		TEXT("On the cabinet sits a photo of several people at some kind of party.\nThe flow of time seems to have worn the caption off of the brass placard."),
		CHOICE("Inspect the photo?",
			OPTION("Sure",			"choiceOfficePhotoYes"),
			OPTION("Don't care",	"choiceOfficePhotoNo"))
	];

		global.topics[$ "choiceOfficePhotoYes"] = 
		[
			TEXT("The guy closest to the camera is a middle aged man with a very trendy old man moustache."),
			TEXT("His arms are outstretched to either side of him.\nHis pose and facial expression give off an odd mix of conflicting emotions."),
			TEXT("Everyone around him seems uncomfortable."),
			SPEAKER("Nils",sPortNils),
			TEXT("Damn, they look like they're having fun..."),
		]
	
		global.topics[$ "choiceOfficePhotoNo"] = 
		[
			TEXT("The photo likely depicts something very important...\nbut I guess it doesn't interest you."),
			SPEAKER("Nils",sPortNils),
			TEXT("Booooriiiiing!"),
		]

	global.topics[$ "officeDesk"] = 
	[
		CHOICE("An expensive looking desk. Its surface is marked with several water rings.",
			OPTION("Check the drawers", "choice desk drawers"),
			OPTION("Check the desktop", "choice desk top"),
			OPTION("Check nothing", "choice desk nothing"))
	];

		global.topics[$ "choice desk drawers"] = 
		[
			TEXT("Despite your wimpiest tug, the desks drawers will not budge. "),
			SPEAKER("Nils",sPortNils,1),
			TEXT("I guess its [c_red]LOCKED[c_white]!\n[portrait,sPortNils,2]I bet something really useful or cool is in there..."),
			SPEAKER(),
			TEXT("The desks drawers are [c_yellow]JAMMED[c_white], not [c_red]LOCKED[c_white].\nThis is universal shorthand for 'Give up'."),
		]

		global.topics[$ "choice desk top"] = 
		[
			TEXT("The desktop is made of a very dark brown wood."),
			TEXT("You know Jack Shit about wood so that's the most you can discern."),
			SPEAKER("Nils",sPortNils),
			TEXT("The perfect arena for a blistering round of solitaire!"),
			SPEAKER("Nils",sPortNils,2),
			TEXT("Not sure why I remember what solitaire is though..."),
			SET(FLAGS,"solitaire", 1)
		]

		global.topics[$ "choice desk nothing"] = 
		[
			TEXT("You check NOTHING. What are you, a nerd?"),
			SPEAKER("Nils",sPortNils),
			TEXT("Stupid nerd desk! I don't even care about your drawer contents or anything!")
		]

#endregion

#region rOffice_1
	global.topics[$ "officeHallSign1"] = 
	[
		SPEAKER(),
		TEXT("An office name plate hangs beside the frosted glass door."),
		TEXT("Ted Merkle\nDesign Lead")
	];

	global.topics[$ "officeHallSign2"] = 
	[
		SPEAKER(),
		TEXT("An office name plate hangs beside the frosted glass door."),
		TEXT("Evelyn Proust\nLogistics")
	];

	global.topics[$ "officeHallSign3"] = 
	[
		SPEAKER(),
		TEXT("An office name plate hangs beside the heavy wooden door."),
		TEXT("Bill Wozniak\nDirector"),
		TEXT("Someone seems to have added an accent over the 'z' with whiteout."),
	];
#endregion

#region rOffice_3

	global.topics[$ "cubicleCoffee"] = 
	[
		TEXT("Write something cool about paper"),
		
	]

	global.topics[$ "cubiclePC"] = 
	[
		TEXT("The pc at this desk is the typical outdated government donor pc."),
		TEXT("Hard to imagine a time that this would have been impressive."),
		TEXT("On further inspection, you notice the layout of the the pre-installed Solitaire game faintly burnt into the monitor."),
		CHECKFLAG(FLAGS,"solitaire", "==", 1, "cubicleSolitaire")
	]
	
	global.topics[$ "cubicleSolitaire"] = 
	[
		SPEAKER("Nils",sPortNils),
		TEXT("[shake]I KNEW IT![/shake] How deep does this Solitaire Conspiracy run..."),
	]
	
	global.topics[$ "cubicle1Nothing"] = 
	[
		SPEAKER("Nils",sPortNils),
		TEXT("Who cares..."),
	]
	
	global.topics[$ "cubicleCoffee"] = 
	[
		TEXT("This cubicle is littered with personal adornments."),
		TEXT("A poster reads:" nl "'WARNING[c_red]![c_white] Do not talk to programmer until they've had there coffee! [sLaughingCryingEmoji]'"),
		SPEAKER("Nils",sPortNils,1),
		TEXT("Ugh, lame!"),
		SPEAKER(),
		TEXT("That's not all!"),
		TEXT("Their coffee mug reads:" nl "'WARNING[c_red]![c_white] Do not talk to programmer until they've had there coffee! [sLaughingCryingEmoji]'"),
		TEXT("Both the poster and the mug have the exact same typo."),
		SPEAKER("Nils",sPortNils,3),
		TEXT("Jesus man, was it really THAT funny??"),
	]
#endregion

#region rOfficeBathroom
	global.topics[$ "officeBathroom"] = 
	[
		TEXT("Your creepy skeletal nostril hole is bombarded with the stench of a toilet that hasn't been cleaned in at least a dozen years."),
		GOTO("save"),
	]
#endregion
