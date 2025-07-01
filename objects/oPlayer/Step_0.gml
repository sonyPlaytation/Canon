/// @

depth = -bbox_bottom;

var hdir = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
hsp = walksp*hdir

var vdir = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP);
vsp = walksp*vdir

move_and_collide(hsp,vsp,[oColl,tiles]);