
var broadcast_type = event_data[? "event_type"];
var broadcast_message = event_data[? "message"];
var message_listener = layer_instance_get_instance(event_data[? "element_id"]);

if (broadcast_type == "sprite event" and message_listener == id) {
    
    if instance_exists(oBattle) and oBattle.currentUser == id and broadcast_message == "perform" {oBattle.perform = true; exit;}
	SFX asset_get_index(event_data[? "message"])
}
