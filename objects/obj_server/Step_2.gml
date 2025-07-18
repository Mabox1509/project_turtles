//CHECK


// SEND DATA TO CLIENTS
var _clients = ds_map_keys_to_array(clients);

for (var _i = 0; _i < array_length(_clients); _i++)
{
	var _id = _clients[_i];
	var _client = clients[? _id];

	if (array_length(_client.outbox) > 0)
	{		
		var _buffer = neat_serialize(_client.outbox);
		
		network_send_packet(_id, _buffer, buffer_get_size(_buffer));
		buffer_delete(_buffer);

		_client.outbox = [];
	}
}
