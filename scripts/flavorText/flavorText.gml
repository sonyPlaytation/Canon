
#macro FLAGS global.flags

global.flags = 
{
	//running jokes
	solitaire: 0
}
//dialogue
//textSoundLUT()

#region rOffice
global.topics[$ "officeDesk"] = 
[
	SPEAKER(),
	CHOICE("A very expensive looking desk. Its surface is marked with several water rings.",
		OPTION("Check the drawers", "choice desk drawers"),
		OPTION("Check the desktop", "choice desk top"),
		OPTION("Check nothing", "choice desk nothing"))
];

global.topics[$ "officePhoto"] = 
[
	SPEAKER(),
	TEXT("On the wall hangs a large framed photo of a rather large group of people.\nThe flow of time seems to have worn the caption off of the brass placard."),
	CHOICE("Inspect the photo?",
		OPTION("Sure",			"choiceOfficePhotoYes"),
		OPTION("Don't care",	"choiceOfficePhotoNo"))
];

	global.topics[$ "choiceOfficePhotoYes"] = 
	[
		TEXT("In the middle of the crowd stands a middle aged man with a very trendy old man moustache."),
		TEXT("His arms are outstretched in such a way that makes his intent kind of difficult to parse."),
		TEXT("Everyone around him looks uncomfortable."),
		SPEAKER("Nils",sPortNils),
		TEXT("They look like they're having fun!"),
	]
	
	global.topics[$ "choiceOfficePhotoNo"] = 
	[
		TEXT("The photo depicts something likely very important, but I guess it doesn't interest you."),
		SPEAKER("Nils",sPortNils),
		TEXT("Booooriiiiing!"),
	]

global.topics[$ "officeDesk"] = 
[
	SPEAKER(),
	CHOICE("A very expensive looking desk. Its surface is marked with several water rings.",
		OPTION("Check the drawers", "choice desk drawers"),
		OPTION("Check the desktop", "choice desk top"),
		OPTION("Check nothing", "choice desk nothing"))
];

	global.topics[$ "choice desk drawers"] = 
	[
		TEXT("Despite your wimpiest tug, the desks drawers will not budge. "),
		SPEAKER("Nils",sPortNils,1),
		TEXT("I guess its [c_red]LOCKED[c_white]! I bet something really useful or cool is in there..."),
		SPEAKER(),
		TEXT("The desks drawers are [c_yellow]JAMMED[c_white], not [c_red]LOCKED[c_white].\nThis is universal shorthand for 'Give up'."),
	]

	global.topics[$ "choice desk top"] = 
	[
		TEXT("The desktop is made of a very dark brown wood."),
		TEXT("You know jack shit about wood so that's the most you can discern."),
		SPEAKER("Nils",sPortNils),
		TEXT("The perfect arena for a blistering round of solitaire!"),
		SPEAKER("Nils",sPortNils,2),
		TEXT("Not sure why I remember what solitaire is though..."),
		SET("solitaire", 1)
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


{ //choices
	global.topics[$ "cubicleCoffee"] = 
	[
		TEXT("Write something cool about paper"),
		
	]

	global.topics[$ "cubiclePC"] = 
	[
		TEXT("The pc at this desk is the typical outdated government donor pc."),
		TEXT("Hard to imagine a time that this would have been impressive."),
		TEXT("On further inspection, you notice the layout of the the pre-installed Solitaire game faintly burnt into the monitor."),
		CHECK("solitaire", "==", 1, "cubicleSolitaire")
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
}


#endregion