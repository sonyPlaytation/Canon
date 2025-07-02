/// @

var confirm = InputPressed(INPUT_VERB.ACCEPT);

progress = min(progress + spd, length);

if typist.get_state() >= 1
{
	if confirm {next()};
}
else if confirm 
{
	typist.skip();
};
