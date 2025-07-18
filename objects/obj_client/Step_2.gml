// SEND DATA TO SERVER
if (array_length(outbox) > 0)
{
	var _buffer= neat_serialize(outbox);
		
	network_send_packet(global.neat.socket, _buffer, buffer_get_size(_buffer));

	buffer_delete(_buffer);

	outbox = [];
}


var _dt = delta_time / 1000000;
alive_timer += _dt;
if(alive_timer > 5)
{
	neat_stop();
	show_message(scr_text("online_timeout"));
	room_goto(rm_multiplayer);
}