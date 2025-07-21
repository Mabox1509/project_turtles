//[VARIABLES]
cursor_inst = instance_create_depth(0, 0, -500, obj_cursor);
lan_rect = instance_create_depth(11, 67, 0, obj_rect);
lan_rect.func_resize(170, 114);
lan_rect.can_scroll = true;

title_text = scr_text("header_play");
search_text  = scr_text("online_search");

connect_ip = "";
connect_port = 0;
async_box_id = -1;

direct_state = -1;
broadcast_socket = network_create_socket_ext(network_socket_udp, BROADCAST_PORT);


lan_servers = ds_map_create();

//[FUNCTIONS]
func_direct= function()
{
	direct_state = 0;
	async_box_id = get_string_async(scr_text("online_ip"), "");
}
func_connect = function()
{
	if(neat_client(connect_ip, connect_port))
	{
		global.screen_fade = 1;
		neat_send2_server("validate", [BUILD]);
	}
	else
	{
		direct_state = -1;
		async_box_id  = -1;
		global.cursor_enable = true;
		
		
	}
}

//[INIT]
global.cursor_enable = false;
window_set_caption(GAME_NAME + " (multiplayer)");

//[ALARM]
alarm[0] = 10;