if(global.neat.state == NetworkState.Server)
{
	players[0].connected = true;
	players[0].ping = 0;
	
	for (var _i = 1; _i < 4; _i++)
	{
		players[_i].connected = obj_server.players_slots[_i];
		
		if(!players[_i].connected)
			players[_i].ping = 0;
	}
	
	/*var _keys = ds_map_keys_to_array(obj_server.clients);
	var _count = array_length(_keys);*/
	
	
	for (var _i = 0; _i < 4; _i++)
	{
		players[_i].connected = obj_server.players_slots[_i];
	}
	
	obj_server.server_motd = inst_59BB0A99.options[inst_59BB0A99.index] + " - " + inst_3DF190A7.options[inst_3DF190A7.index] ;
}