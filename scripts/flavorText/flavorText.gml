
#macro FLAGS global.flags
#macro nl +"\n"+
#macro JAMMED +"[c_red]JAMMED[c_white]"+
#macro LOCKED +"[c_yellow]LOCKED[c_white]"+

function initFlavorText() {

	global.flags = 
	{
		cutscenes :[],
        enemiesActive : DEV,
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

	global.topics[$ "jammed"] = [TEXT("[snSH2DoorLocked]//The lock is "JAMMED"!\nThis door can't be opened.")]
	global.topics[$ "lockedGeneric"] = [TEXT("//It's "LOCKED".")]
	global.topics[$ "unlockedGeneric"] = [TEXT("//You unlock the door.")]

	global.topics[$ "saveFlies"] = 
	[
		TEXT("//A group of smelly flies buzz around you, each one chasing anothers smell."nl"//They are caught in an unending ouroboruos of stench..."),
		GOTO("save")
	
	]

	global.topics[$ "save"] = 
	[

		CHOICE("//Would you like to save your progress?",
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
			TEXT("//On the cabinet sits a photo of several people at some kind of party."nl"//Its placard reads 'FEESE Wrap Party 20XX'"),
			TEXT("//It doesn't LITERALLY say 20XX, it's just scratched in such a way that you can't make out the last two digits."nl"//How inconvenient..."),
			CHOICE("//Inspect the photo?",
				OPTION("Sure",			"choiceOfficePhotoYes"),
				OPTION("Don't care",	"choiceOfficePhotoNo"))
		];

			global.topics[$ "choiceOfficePhotoYes"] = 
			[
				TEXT("//The guy closest to the camera is a middle aged man with a very trendy old man moustache. He looks to be about 60."),
				TEXT("//He's in the middle of stretching his arms to either side of him, but it's an intensely awkward gesture."nl"//He looks like he was probably wasted, I'd say 81% chance."),
				TEXT("//Everyone around him seems uncomfortable."),
				SPEAKER(global.playerName,sPortNils),
				TEXT("Damn, they look like they're having fun..."),
			]
	
			global.topics[$ "choiceOfficePhotoNo"] = 
			[
				TEXT("//The photo likely depicts something very important..."nl"//I guess it doesn't interest you."),
				SPEAKER(global.playerName,sPortNils),
				TEXT("Booooriiiiing!"),
			]

		global.topics[$ "officeDesk"] = 
		[
			CHOICE("//You eye the expensive looking desk you woke up in front of."nl"//It still looks new, yet its surface is marked with several water rings.",
				OPTION("Check the drawers", "choice desk drawers"),
				OPTION("Check the desktop", "choice desk top"),
				OPTION("Check nothing", "choice desk nothing"))
		];

			global.topics[$ "choice desk drawers"] = 
			[
				TEXT("//Despite your wimpiest tug, the desks drawers will not budge. "),
				SPEAKER(global.playerName,sPortNils,1),
				TEXT("I guess its [c_red]LOCKED[c_white]!\n[portrait,sPortNils,2]I bet something really useful or cool is in there..."),
				SPEAKER(),
				TEXT("//The desks drawers are "JAMMED", not "LOCKED"."nl"//This is universal shorthand for 'Give up'."),
			]

			global.topics[$ "choice desk top"] = 
			[
				TEXT("//The desktop is made of a very dark brown wood."),
				TEXT("//You know Jack Shit about wood so that's the most you can discern."),
				SPEAKER(global.playerName,sPortNils),
				TEXT("The perfect arena for a blistering round of solitaire!"),
				SPEAKER(global.playerName,sPortNils,2),
				TEXT("Not sure why I remember what solitaire is though..."),
				SET(FLAGS,"solitaire", 1)
			]

			global.topics[$ "choice desk nothing"] = 
			[
				TEXT("//You check nothing, I guess."),
				SPEAKER(global.playerName,sPortNils),
				TEXT("Stupid nerd desk! I don't even care about your drawer contents or anything!")
			]

		global.topics[$ "officeFilingCabinet"] = 
		[
			TEXT("//Before you stands a temptingly slate-toned filing cabinet, no doubt full to bursting with [c_red]Lascivious Business Secrets."),
			CHOICE("//Search for sexy secrets?",
				OPTION("Indulge...", "officeFilingCabinet Choice1"),
				OPTION("Remain chaste!", "officeFilingCabinet Choice2"))
		];

		global.topics[$ "officeFilingCabinet Choice1"] = 
		[
			SPEAKER(global.playerName,sPortNils,2),
			TEXT("Perhaps I am a sick pervert, what do I know?"),
			SPEAKER(global.playerName,sPortNils,0),
			TEXT("Time to yank this bad boy wide open!"),
			SPEAKER(),
			TEXT("//You begin to yank it, revealing a plethora of manilla folders grouped by year."nl"//The years range from 2085 to 2093, the last of which is comparably much lighter."),
			TEXT("//Your ass is NOT reading these."),
			SPEAKER(global.playerName,sPortNils,1),
			TEXT("2093... that means..."),
			SPEAKER(global.playerName,sPortNils,0),
			TEXT("HOLY CRAP I'M IN THE FUTURE!!!"),
			SPEAKER(global.playerName,sPortNils,1),
			TEXT("Or actually..."nl"No that doesn't really tell me anything. Damn!"),
		]

		global.topics[$ "officeFilingCabinet Choice2"] = 
		[
			SPEAKER(global.playerName,sPortNils),
			TEXT("Nice try, idiot! "nl"These Sexy Secrets are to be kept between a cabinet and its zero to one hundred manilla folder wives!"),
			SPEAKER(),
			TEXT("//Your will-power is truly outstanding."nl"//These hallowed aluminum handles remain un-yanked... for now...")
		]

	#endregion

	#region rOffice_1
		global.topics[$ "officeHallSign1"] = 
		[
			SPEAKER(),
			TEXT("//An office name plate hangs beside the frosted glass door."),
			TEXT("//Ted Merkle\n//Design Lead")
		];

		global.topics[$ "officeHallSign2"] = 
		[
			SPEAKER(),
			TEXT("//An office name plate hangs beside the frosted glass door."),
			TEXT("//Evelyn Proust\n//Logistics")
		];

		global.topics[$ "officeHallSign3"] = 
		[
			SPEAKER(),
			TEXT("//An office name plate hangs beside the heavy wooden door."),
			TEXT("//Bill Wozniak\n//Director"),
			TEXT("//Someone seems to have added an accent over the 'z' with whiteout."),
		];
	#endregion

	#region rOffice_3

		global.topics[$ "cubicleCoffee"] = 
		[
			TEXT("//Write something cool about paper"),
		]

		global.topics[$ "cubiclePC"] = 
		[
			TEXT("//At this desk sits a typical outdated government donor pc."),
			TEXT("//It's probably just barely good enough for word processing and the like." nl"//In other words, it's a total piece of shit."),
			TEXT("//On further inspection, you notice the layout of the the pre-installed Solitaire game faintly burnt into the monitor."),
			CHECKFLAG(FLAGS,"solitaire", "==", 1, "cubicleSolitaire")
		]
	
		global.topics[$ "cubicleSolitaire"] = 
		[
			SPEAKER(global.playerName,sPortNils),
			TEXT("[shake]I KNEW IT![/shake] How deep does this Solitaire Conspiracy run..."),
		]
	
		global.topics[$ "cubicle1Nothing"] = 
		[
			SPEAKER(global.playerName,sPortNils),
			TEXT("Who cares..."),
		]
	
		global.topics[$ "cubicleCoffee"] = 
		[
			TEXT("//This cubicle is littered with personal adornments."),
			TEXT("//A poster reads:" nl "'WARNING[c_red]![c_white] Do not talk to programmer until they've had there coffee! [sLaughingCryingEmoji]'"),
			SPEAKER(global.playerName,sPortNils,1),
			TEXT("Ugh, lame!"),
			SPEAKER(),
			TEXT("//That's not all!"),
			TEXT("//Their coffee mug reads:" nl "'WARNING[c_red]![c_white] Do not talk to programmer until they've had there coffee! [sLaughingCryingEmoji]'"),
			TEXT("//Both the poster and the mug have the exact same typo."),
			SPEAKER(global.playerName,sPortNils,3),
			TEXT("Jesus man, was it really THAT funny??"),
		]
	#endregion

	#region rOfficeBathroom
		global.topics[$ "officeBathroom"] = 
		[
			TEXT("//Your creepy skeletal nostril hole is bombarded with the stench of a toilet that hasn't been cleaned in at least a dozen years."),
			GOTO("save"),
		]
	#endregion

}