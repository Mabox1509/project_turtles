//CHECKS
if(async_load[? "type"] != network_type_data)
	exit;
	
if(async_load[? "id"] != broadcast_socket)
	exit;
	
//DATA
var _buffer = async_load[? "buffer"];
buffer_seek(_buffer, buffer_seek_start, 0);
var _string = buffer_read(_buffer, buffer_string);

try
{
	var _serv_entry = json_parse(_string);
	var _ip = async_load[? "ip"];
	
	var _key = _ip + ":" + string(_serv_entry.port);
	if(!ds_map_exists(lan_servers, _key))
	{
		var _y = 26 * (ds_map_size(lan_servers));
		
		var _inst = instance_create_depth(0, _y, 0 ,obj_button_server);
		_inst.func_parent(lan_rect);
		
		_inst.ip = _ip;
		_inst.port = _serv_entry.port;
		_inst.motd = _serv_entry.motd;
		_inst.players = _serv_entry.players;
		_inst.compatible = _serv_entry.build == BUILD;
		
		lan_servers[? _key] = _inst;
		
		lan_rect.max_scroll = max(0, (26 * ds_map_size(lan_servers)) - 114);
		//show_message(lan_rect.max_scroll);
	}
	else
	{
		var _inst = lan_servers[? _key];
		
		_inst.motd = _serv_entry.motd;
		_inst.players = _serv_entry.players;
	}
}