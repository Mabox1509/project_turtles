var _spawn = func_find_valid_spawn();
neat_spawn(_spawn[0], _spawn[1], obj_player, global.neat.session_id);

var _keys = ds_map_keys_to_array(obj_server.clients);
var _count = array_length(_keys);

for (var _i = 0; _i < _count; _i++)
{
	var _socket = _keys[_i];
	_spawn = func_find_valid_spawn();
	neat_spawn(_spawn[0], _spawn[1], obj_player, _socket);
}


var _enemys_count = random_range(5, 10);
for(var _i = 0;_i < _enemys_count;_i++)
{
	_spawn = func_find_valid_spawn();
	neat_spawn(_spawn[0], _spawn[1], obj_enemy, global.neat.session_id);
}