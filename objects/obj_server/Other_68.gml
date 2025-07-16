var _id = async_load[? "id"];
var _socket = async_load[? "socket"];

var msg = "";

var keys = ds_map_keys_to_array(async_load);
var key_count = array_length(keys);

for (var i = 0; i < key_count; ++i)
{
    var key = keys[i];
    var val = async_load[? key];
    msg += string(key) + ": " + string(val) + "\n";
}

//show_message(msg);



switch(async_load[? "type"])
{
	case network_type_connect:	
		
		if(_id != global.neat.socket)
			exit;
			
		//show_message("New client");
		
		clients[? _socket] = 
		{
			outbox : [],
			cache : array_create(32, 0),
			
			slot : -1,
			avatar_id : -1,
		};
		
		/*neat_send2_client(0x01, [_socket, _slot], _socket); // Login
		
		//Spawn pre existing entitys
		var _ids = ds_map_keys_to_array(global.entities);
		for (var i = 0; i < array_length(_ids); i++)
		{
			var _key = _ids[i];
			var _inst = global.entities[? _key];
			
			neat_send2_client(0x02, [_inst.x, _inst.y, _inst.object_index, _inst.net_id, _inst.owner], _socket); //Spawn
		}
		
		 clients[? _socket].avatar_id = neat_spawn(32, 32, obj_player, _socket).net_id;*/
		 //show_message(json_stringify(clients[? _socket], false));
	break;
	
	
	case network_type_disconnect:

	
		if (ds_map_exists(clients, _socket))
		{
			if(clients[? _socket].slot > 0)
				players_slots[clients[? _socket].slot] = false;
				
			if(clients[? _socket].avatar_id > 0)
				neat_destroy(global.entities[? clients[? _socket].avatar_id])
			
			ds_map_delete(clients, _socket);
			
			
		}
	break;
	
	
	case network_type_data:
		var _buffer = async_load[? "buffer"];
		
		if(async_load[? "server"] != global.neat.socket)
			exit;
		
		//var _raw_size = buffer_get_size(_buffer);
		var _decompressed = buffer_decompress(_buffer);
		
		buffer_seek(_decompressed, buffer_seek_start, 0);
	
		neat_handler(_decompressed, _id);
	
		buffer_delete(_decompressed);
	break;
}
