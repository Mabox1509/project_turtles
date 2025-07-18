global.server_opcodes = ds_map_create();


//Validate
global.server_opcodes[? "validate"] = 
{
	parse: 
	[
		buffer_u32, //Client build version
	],
	handler: function(_socket, _args)
	{
		if(_args[0] != BUILD)
		{
			//KICK IF BUILD DON'T MACH
			neat_send2_client("kick", ["version"], _socket);
		}
		else
		{
			//KICK IF THE SERVER IS NOT JOINABLE
			if(!global.neat.joinable)
			{
				neat_send2_client("kick", ["join"], _socket);
				return;
			}
			
			//ADD 2 CLIENTS LIST
			obj_server.clients[? _socket] = 
			{
				outbox : [],
				cache : array_create(32, 0),
			
				slot : -1,
				avatar_id : -1,
				loading : -1,
			};
		
			
			
			var _slot = 1;
			for(var _i = 1;_i < 4;_i++)
			{
				if(!obj_server.players_slots[_i])
				{
					obj_server.players_slots[_i] = true;
					_slot = _i;
					break;
				}
			}
			obj_server.clients[? _socket].slot = _slot;
			
			neat_send2_client("accept", [_socket, _slot], _socket);
		}
		
		
	}
};

//Alive
global.server_opcodes[? "alive"] = 
{
	parse: [],
	handler: function(_socket, _args)
	{
		neat_send2_client("alive", [], _socket);
	}
};

//Ping
global.server_opcodes[? "pong"] = 
{
	parse: [buffer_u16],
	handler: function(_socket, _args)
	{
		if(!ds_map_exists(obj_server.clients, _socket))
		{
			network_destroy(_socket);
			return;
		}
		
		if(room == rm_lobby)
		{
			var _slot = obj_server.clients[? _socket].slot;
			
			obj_menu_lobby.players[_slot].ping = max(1, (current_time - obj_menu_lobby.last_ping) - _args[0]);
		}
	}
};

//Room Loaded
global.server_opcodes[? "room_loaded"] = 
{
	parse: [buffer_u32], // Room
	handler: function(_socket, _args)
	{
		var _expected_room = obj_server.clients[? _socket].loading;

		if (_args[0] != _expected_room)
		{
			neat_send2_client("kick", ["room"], _socket);
		}
		else
		{
			obj_server.clients[? _socket].loading = -1;

			// Verificar si TODOS los clientes han terminado de cargar
			var _all_loaded = true;
			var _keys = ds_map_keys_to_array(obj_server.clients);
			var _count = array_length(_keys);

			for (var i = 0; i < _count; ++i)
			{
				var _key = _keys[i];
				var _client = obj_server.clients[? _key];

				if (is_undefined(_client)) continue;

				if (_client.loading != -1)
				{
					_all_loaded = false;
					break;
				}
			}

			if (_all_loaded)
			{
				global.clients_room_sync = true;
			}
		}
	}
};


//Sync entity
global.server_opcodes[? "entity_sync"] = 
{
	parse:
	[
		buffer_u32, //id
		
		buffer_s16,  //x
		buffer_s16,  //y
		
		buffer_f32,  //xvel
		buffer_f32,  //yvel
		
		buffer_s32,  //sprite
		buffer_f32,  //frame
		
		buffer_s16,  //rot
		buffer_u32  //color
		
	], //id, x, y, xvel, yvel, sprite, frame, rot
	handler: function(_socket ,_args)
	{
		//show_message_async(_args);
		var _inst = global.entities[? _args[0]];
		if(obj_server.clients[? _socket].slot < 0)
		{
			network_destroy(_socket);
			return;
		}
		
		if(_inst.owner == global.neat.session_id)
			return;
		
		_inst.x = _args[1];
		_inst.y = _args[2];
		
		_inst.vel_x = _args[3];
		_inst.vel_y = _args[4];
		
		_inst.sprite_index = _args[5];
		_inst.image_index = _args[6];
		
		_inst.visual_angle = _args[7];
		
		_inst.image_blend = _args[8];
	}
};