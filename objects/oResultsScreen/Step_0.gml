/// @




alpha = lerp(alpha,alphaTarg,0.1)

if h < targH and alpha >= alphaTarg*0.9 {h = approach(h,targH,12)}

if InputPressed(INPUT_VERB.ACCEPT)
{
	transition(room, sqBattleEnd, sqFadeIn, true);
}