if (global.clients_room_sync)
{
	neat_spawn(16 , 16, obj_player, global.neat.session_id);
	var _keys = ds_map_keys_to_array(obj_server.clients);
	var _count = array_length(_keys);

	for (var _i = 0; _i < _count; _i++)
	{
		var _socket = _keys[_i];
		neat_spawn(32, 32, obj_player, _socket);
	}

	neat_spawn(64 , 64, obj_enemy, global.neat.session_id);
}
else
{
	alarm[0] = 10;
}
