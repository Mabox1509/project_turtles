global.client_opcodes = ds_map_create();

//Pong
global.client_opcodes[? "ping"] =
{
	parse: [], //Session id, slot
	handler: function(_args)
	{
		var _dt = delta_time / 1000000;
		
		neat_send2_server("pong", [floor(_dt * 1000)]);
	}
};

//Kick
global.client_opcodes[? "kick"] = 
{
	parse: [buffer_string], //Kick motive
	handler: function(_args)
	{
		neat_stop();
		show_message(scr_text("online_kick_" + _args[0]));
		room_goto(rm_multiplayer);
	}
};

//Accepted
global.client_opcodes[? "accept"] = 
{
	parse: [buffer_s16, buffer_u8], //Session id, slot
	handler: function(_args)
	{
		global.neat.session_id = _args[0];
		global.neat.player_index = _args[1];
		
		room_goto(rm_lobby);	
	}
};

//Lobby status
global.client_opcodes[? "status"] =
{
	parse:
	[
		//Player 1
		buffer_bool, //Connected
		buffer_u16,  //Ping
		
		//Player 2
		buffer_bool, //Connected
		buffer_u16,  //Ping
		
		//Player 3
		buffer_bool, //Connected
		buffer_u16,  //Ping,
		
		buffer_u8, //Map
		buffer_u8 //Dificulty
	],
	handler: function(_args)
	{
		if(room == rm_lobby)
		{
			obj_menu_lobby.players[0].connected = true;
			obj_menu_lobby.players[0].ping = 0;
			
			obj_menu_lobby.players[1].connected = _args[0];
			obj_menu_lobby.players[1].ping = _args[1];
			
			obj_menu_lobby.players[2].connected = _args[2];
			obj_menu_lobby.players[2].ping = _args[3];
			
			obj_menu_lobby.players[3].connected = _args[4];
			obj_menu_lobby.players[3].ping = _args[5];
			
			inst_59BB0A99.index = _args[6];
			inst_3DF190A7.index = _args[7];
		}
	}
};

//Spawn entity
global.client_opcodes[? "entity_spawn"] = 
{
	parse: [buffer_s16, buffer_s16, buffer_u32, buffer_u32, buffer_u32], // x, y, type, id, owner
	handler: function(_args)
	{
		var _inst = instance_create_depth(_args[0], _args[1], 0, _args[2]);
		_inst.func_setid(_args[3]);
		_inst.owner = _args[4];

		
		//show_message("New entity created with id: " + string(_inst.net_id));
	}
};
//Sync entity
global.client_opcodes[? "entity_sync"] = 
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
	handler: function(_args)
	{
		var _inst = global.entities[? _args[0]];
		
		//show_message(_inst);
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
//Despawn entity
global.client_opcodes[? "entity_despawn"] = 
{
	parse: [buffer_u32], // x, y, type, id, owner
	handler: function(_args)
	{
		var _inst = global.entities[? _args[0]];
		instance_destroy(_inst);
		
		//show_message("New entity created with id: " + string(_inst.net_id));
	}
};