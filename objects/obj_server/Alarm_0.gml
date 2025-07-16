var _message = 
{
	motd : server_motd,
	
	build : BUILD,
	port : global.neat.port,
	join : global.neat.joinable,
	players : ds_map_size(clients) + 1
};
var _json = json_stringify(_message, true);

var _buffer = buffer_create(string_length(_json)+1, buffer_fixed, 1);
buffer_poke(_buffer, 0, buffer_string, _json);

//SEND
network_send_broadcast(broadcast_socket, BROADCAST_PORT, _buffer, buffer_get_size(_buffer));
buffer_delete(_buffer);

//REPEAT
alarm[0] = 60;