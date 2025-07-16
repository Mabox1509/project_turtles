//[VARIABLES]
global.screen_fade = 1;
obj_screen.fade = 1;

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


//[INIT]
global.cursor_enable = false;
if(global.neat.state == NetworkState.Server)
{
	alarm[1] = 1;
	alarm[2] = 60;
}


//[ALARM]
alarm[0] = 10;