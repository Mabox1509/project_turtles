//[ENUMS & MACROS]
enum NetworkState
{
	Noone,
	Server,
	Client,
}

randomize();
#macro DEFAULT_PORT 4800
#macro BROADCAST_PORT  5900


//[GLOBALS]
global.neat = 
{
	instance : noone,
	state: NetworkState.Noone,
	
	ip : "",
	port : -1,
	socket : -1,
	
	session_id : -1,
	player_index : 0,
	
	joinable : true,
};
global.skin_colors = 
[
	#bfd4b0,
	#d9af80,
	#b07972,
	#7f9bb0
];
//global.chat = [];


//[FUNCTIONS]
function neat_stop()
{
	//Check
	if(global.neat.state == NetworkState.Noone)
		return;
		

	
	//Destroy socket
	instance_destroy(global.neat.instance);
	network_destroy(global.neat.socket);
	
	//Reset all
	global.neat.state = NetworkState.Noone;
	global.neat.socket = -1;
	global.neat.ip = "";
	global.neat.port = -1;
	global.neat.session_id = -1;
	global.neat.player_index = -1;
	global.neat.joinable = false;
	
	//ds_map_clear(global.neat.cache);
	
	show_debug_message("Neat stopped");
}

function neat_server()
{
	//DESTROY PREVIUS
	if(global.neat.state != NetworkState.Noone)
		throw "Network alredy initialized.";
		
	if(instance_exists(global.neat.instance))
		instance_destroy(global.neat.instance);

	
	//CREATE SOCKET
	global.neat.ip = "localhost";
	global.neat.port = DEFAULT_PORT;
	
	do
	{
		global.neat.socket = network_create_server(network_socket_tcp, global.neat.port, 3);
		global.neat.port++;
	}
	until(global.neat.socket >= 0)
	
	
	global.neat.port--;
	show_debug_message("\n=====================================");
	show_debug_message("Server opened on port: " + string(global.neat.port));
	show_debug_message("Socket ID: " + string(global.neat.socket));
	show_debug_message("=====================================\n");
	
	//CREATE INSTANCE	
	global.neat.state = NetworkState.Server;
	global.neat.instance = instance_create_depth(0, 0, 0 ,obj_server);
	global.neat.session_id = global.neat.socket;
	global.neat.player_index = 0;
	global.neat.joinable = true;
	//global.chat = [];
}
function neat_client(_ip, _port)
{
	//DESTROY PREVIUS
	if(global.neat.state != NetworkState.Noone)
		throw "Network alredy initialized.";
		
	if(instance_exists(global.neat.instance))
		instance_destroy(global.neat.instance);

	
	// CREATE SOCKET
	global.neat.ip = _ip;
	global.neat.port = _port;
	global.neat.socket = network_create_socket(network_socket_tcp);
	
	//CONNECT 2 SERVER
	if (network_connect(global.neat.socket, global.neat.ip, global.neat.port) < 0)
	{
		show_message("Could not connect to server at " + string(global.neat.ip) + ":" + string(global.neat.port));
		neat_stop();
		return false;
	}

	

	show_debug_message("\n=====================================");
	show_debug_message("Connected to server successfully!");
	show_debug_message("IP: " + string(global.neat.ip));
	show_debug_message("Port: " + string(global.neat.port));
	show_debug_message("Socket ID: " + string(global.neat.socket));
	show_debug_message("=====================================\n");

	
	//CREATE INSTANCE
	global.neat.state = NetworkState.Client;
	global.neat.instance = instance_create_depth(0, 0, 0 ,obj_client);
	global.neat.session_id = 0;
	global.neat.player_index = -1;
	global.neat.joinable = false;
	//global.chat = [];
	
	return true;
}

function neat_make_message(_opcode, _args, _server)
{
    var _table = _server ? global.client_opcodes : global.server_opcodes;

    if (!ds_map_exists(_table, _opcode))
        throw "Invalid opcode: " + string(_opcode);

    var _entry = _table[? _opcode];
    var _types = _entry.parse;

    if (array_length(_args) != array_length(_types))
        throw "Argument count mismatch for opcode " + string(_opcode);

    var _final_args = [];

    for (var i = 0; i < array_length(_args); i++)
    {
        var _type = _types[i];
        var _arg = _args[i];

        if (_type == -1)
        {
		// Clonar el buffer
		var _clone = buffer_create(buffer_get_size(_arg), buffer_fixed, 1);
		buffer_copy(_arg, 0, buffer_get_size(_arg), _clone, 0);
		array_push(_final_args, _clone);
        }
        else
	{
		array_push(_final_args, _arg);
        }
}

    return {
        opcode: _opcode,
        args: _final_args
    };
}
function neat_serialize(_list)
{
	var _table = global.neat.state == NetworkState.Server ? global.client_opcodes : global.server_opcodes;	
	
	var _buffer = buffer_create(1024, buffer_grow, 1);
	buffer_seek(_buffer, buffer_seek_start, 0);
	buffer_write(_buffer, buffer_u32, array_length(_list));

	for (var _j = 0; _j < array_length(_list); _j++)
	{
		var _msg = _list[_j];
		var _opcode = _msg.opcode;
		var _args = _msg.args;

		buffer_write(_buffer, buffer_string, _opcode);

		var _entry = _table[? _opcode];
		var _types = _entry.parse;

		for (var _k = 0; _k < array_length(_args); _k++)
		{
			var _type = _types[_k];
			var _arg = _args[_k];

			if (_type == -1)
			{
				var _size = buffer_get_size(_arg);
				buffer_write(_buffer, buffer_u32, _size);

				for (var _b = 0; _b < _size; _b++)
				{
					var _byte = buffer_peek(_arg, _b, buffer_u8);
					buffer_write(_buffer, buffer_u8, _byte);
				}

				buffer_delete(_arg);
			}
			else
			{
				buffer_write(_buffer, _type, _arg);
			}
		}
	}

	var _compress = buffer_compress(_buffer, 0, buffer_get_size(_buffer));
	buffer_delete(_buffer);
	
	return _compress;
}

function neat_send2_client(_opcode, _args, _target)
{
	if(global.neat.state == NetworkState.Noone)
		return;
	
	if(global.neat.state != NetworkState.Server)
		throw "This is a server-side function.";
		
	//Check messsage
	if(!ds_map_exists(global.client_opcodes, _opcode))
		throw "Trying to send a invalid opcode to client.";
		
	if(array_length(global.client_opcodes[? _opcode].parse) != array_length(_args))
		throw "Invalid number of arguments.";
		
	
	if(_target < 0) //Send 2 all clients
	{
		var _clients = ds_map_keys_to_array(obj_server.clients);

		for (var _i = 0; _i < array_length(_clients); _i++)
		{
			array_push
			(
				obj_server.clients[? _clients[_i]].outbox,
				neat_make_message(_opcode, _args, true)
			);
		}
	}
	else
	{
		if (ds_map_exists(obj_server.clients, _target))
		{
			array_push(
		        obj_server.clients[? _target].outbox,
		        neat_make_message(_opcode, _args, true)
		    );
		}
		else
		{
			_list = [];
			array_push(_list, neat_make_message(_opcode, _args, true));
			
			var _buffer = neat_serialize(_list);
			network_send_packet(_target, _buffer, buffer_get_size(_buffer));
			
			buffer_delete(_buffer);
		}

		    
	}
}
function neat_send2_server(_opcode, _args)
{
	if(global.neat.state == NetworkState.Noone)
		return;
	
    if (global.neat.state != NetworkState.Client)
        throw "This is a client-side function.";

    // Check message
    if (!ds_map_exists(global.server_opcodes, _opcode))
        throw "Trying to send an invalid opcode to server.";

    if (array_length(global.server_opcodes[? _opcode].parse) != array_length(_args))
        throw "Invalid number of arguments.";

    var _msg = neat_make_message(_opcode, _args, false);

    // Enviar al servidor (suponiendo que global.neat.socket es el socket del server)
    array_push(obj_client.outbox, _msg);
}


function neat_handler(_buffer, _socket = -1)
{
	// Read number of instructions
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _count = buffer_read(_buffer, buffer_u32);
	
	// Select opcode table
	var _table = global.neat.state == NetworkState.Server ? global.server_opcodes : global.client_opcodes;
	
	// Handle opcodes
	for (var _i = 0; _i < _count; _i++)
	{
		var _opcode = buffer_read(_buffer, buffer_string);
		
		if (!ds_map_exists(_table, _opcode))
			continue; // Saltar si el opcode no está registrado
		
		var _action = _table[? _opcode];
		var _types = _action.parse;
		var _args = array_create(array_length(_types), 0);

		// Parse arguments
		for (var _j = 0; _j < array_length(_types); _j++)
		{
			var _type = _types[_j];

			if (_type == -1)
			{
				var _size = buffer_read(_buffer, buffer_u32);
				var _clone = buffer_create(_size, buffer_fixed, 1);

				for (var _b = 0; _b < _size; _b++)
				{
					var _byte = buffer_read(_buffer, buffer_u8);
					buffer_write(_clone, buffer_u8, _byte);
				}

				buffer_seek(_clone, buffer_seek_start, 0);
				_args[_j] = _clone;
			}
			else
			{
				_args[_j] = buffer_read(_buffer, _type);
			}
		}



		//Call function
		if(global.neat.state == NetworkState.Server)
		{
			_action.handler(_socket, _args);
		}
		else
		{
			_action.handler(_args);
		}
	}
}

function neat_spawn(_x, _y, _type, _owner)
{
	if (!object_is_ancestor(_type, obj_entity))
		throw "Trying to spawn a non-entity object";

	
	switch(global.neat.state)
	{
		case NetworkState.Noone:
			var _inst = instance_create_depth(_x, _y, 0, _type);
			return _inst;
		
		break;
		
		case NetworkState.Server:
			
			var _inst = instance_create_depth(_x, _y, 0, _type);
			_inst.owner = _owner;
	
			_inst.func_setid(-1);
	
			neat_send2_client("entity_spawn", [_inst.x, _inst.y, _inst.object_index, _inst.net_id, _inst.owner], -1);
			return _inst;
		break;
		
		case NetworkState.Client:
			neat_send2_server(0x02, [_x, _y, _type]);
			return undefined;
		break;
	}
	
	/**/
}
function neat_destroy(_inst)
{
	if(global.neat.state == NetworkState.Client)
		throw "A client can't destroy objects";
	
	if (!object_is_ancestor(_inst.object_index, obj_entity))
		throw "Trying to despawn a non-entity object";

	
	
	neat_send2_client("entity_despawn", [_inst.net_id],-1);
	instance_destroy(_inst);
	
	/**/
}

function neat_room_goto(_room)
{
	if (global.neat.state != NetworkState.Server)
		throw "A client can't call a goto function";

	global.screen_fade = 1;
	global.cursor_enable = false;
	
	neat_send2_client("room", [_room], -1);
	
	obj_server.neat_room = _room;
	obj_server.alarm[1] = 30;
	
	
}

//[NETWORK ACTIONS]