var _keys = ds_map_keys_to_array(obj_server.clients);
var _count = array_length(_keys);

for (var _i = 0; _i < _count; _i++)
{
	var _sock = _keys[_i];
	var _client = obj_server.clients[? _sock];

	if (is_array(_client.cache) && array_length(_client.cache) > 10)
	{
		_client.cache[10] = false;
	}
}

neat_send2_client("generation", [map_buffer], -1);
func_gentiles();

alarm[4] = 10;

