/// @

textAlpha = lerp(textAlpha,textAlphaTarg,0.15);

pBattleUnit.visible = false;
global.canPause = false;

//state();
sState.step();
perform = false;

bgx[0] += 1;
bgx[2] += 0.5



