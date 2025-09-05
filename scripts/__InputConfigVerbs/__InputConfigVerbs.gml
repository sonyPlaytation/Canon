function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
		RUN,
        ACCEPT,
		SKIP,
        CANCEL,
        ACTION,
        SPECIAL,
        PAUSE,
		BL,
		BM,
		BH,
		GRUDGE,
		DASH
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH)
    {
		// Movement
        InputDefineVerb(INPUT_VERB.UP,      "up",			[vk_up   ],				[-gp_axislv, gp_padu])
        InputDefineVerb(INPUT_VERB.DOWN,    "down",			[vk_down ],				[ gp_axislv, gp_padd])
        InputDefineVerb(INPUT_VERB.LEFT,    "left",			[vk_left ],				[-gp_axislh, gp_padl])
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",		[vk_right],				[ gp_axislh, gp_padr])
		InputDefineVerb(INPUT_VERB.RUN,		"run",			["X"],					gp_face3);
		InputDefineVerb(INPUT_VERB.DASH,	"dash",			[vk_space],				gp_face2);
																					
		InputDefineVerb(INPUT_VERB.BL,		"light",		["A", "Z"],				gp_face3);
		InputDefineVerb(INPUT_VERB.BM,		"medium",		["S", "X"],				gp_face4);
		InputDefineVerb(INPUT_VERB.BH,		"heavy",		["D", "C"],				gp_face2);
		InputDefineVerb(INPUT_VERB.GRUDGE,	"grudge",		[vk_shift],				gp_shoulderlb);
																					
        InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",		["Z"],					gp_face1);
		InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",		["X"],					gp_face2);
		InputDefineVerb(INPUT_VERB.SKIP,	"skip",			["C"],					gp_face4);
       
        InputDefineVerb(INPUT_VERB.ACTION,  "action",		["E", "Z"],				gp_face1);
        InputDefineVerb(INPUT_VERB.PAUSE,   "pause",		vk_escape,				gp_start);
    }
    else //Flip A/B over on Switch
    {
        // Movement
        InputDefineVerb(INPUT_VERB.UP,      "up",			[vk_up   ],				[-gp_axislv, gp_padu])
        InputDefineVerb(INPUT_VERB.DOWN,    "down",			[vk_down ],				[ gp_axislv, gp_padd])
        InputDefineVerb(INPUT_VERB.LEFT,    "left",			[vk_left ],				[-gp_axislh, gp_padl])
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",		[vk_right],				[ gp_axislh, gp_padr])
		InputDefineVerb(INPUT_VERB.RUN,		"run",			["X"],					gp_face3);
		InputDefineVerb(INPUT_VERB.DASH,	"dash",			[vk_space],				gp_face2);
																					
		InputDefineVerb(INPUT_VERB.BL,		"light",		["A", "Z"],				gp_face3);
		InputDefineVerb(INPUT_VERB.BM,		"medium",		["S", "X"],				gp_face4);
		InputDefineVerb(INPUT_VERB.BH,		"heavy",		["D", "C"],				gp_face2);
		InputDefineVerb(INPUT_VERB.GRUDGE,	"grudge",		[vk_shift],				gp_shoulderlb);
																					
        InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",		["Z"],					gp_face1);
		InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",		["X"],					gp_face2);
		InputDefineVerb(INPUT_VERB.SKIP,	"skip",			["C"],					gp_face4);
       
        InputDefineVerb(INPUT_VERB.ACTION,  "action",		["E", "Z"],				gp_face1);
        InputDefineVerb(INPUT_VERB.PAUSE,   "pause",		vk_escape,				gp_start);
    }	
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}