//[VARIABLES]
global.screen_fade = 1;
obj_screen.fade = 1;
global.neat.joinable = true;

cursor_inst = instance_create_depth(0, 0, -500, obj_cursor);
players = array_create(4, noone);
last_ping = 0;

for(var _i = 0;_i < 4;_i++)
{
	players[_i] = 
	{
		connected : false,
		ping : 0,
	};
}

players_text = scr_text("online_players");
you_text = scr_text("online_you");

//[FUNCTIONS]
func_start = function()
{
	global.neat.joinable = false;
	neat_room_goto(rm_play);
}

//[INIT]
global.cursor_enable = false;
if(global.neat.state == NetworkState.Server)
{
	alarm[1] = 1;
	alarm[2] = 60;
	
	window_set_caption(GAME_NAME + " (server)");
}
else
{
	window_set_caption(GAME_NAME + " (client - " + global.neat.ip + ":" + string(global.neat.port) + ")");
}


//[ALARM]
alarm[0] = 10;