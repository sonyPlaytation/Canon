/// @

// Inherit the parent event
event_inherited();

if stock < fullStock 
{ image_index = 1; }
else if !instance_exists(oTextBox)
{ image_index = 0; }
 