if(index == 0)
{
	room_goto(rm_multiplayer);
}
else if(index == 1)
{
	
}
else if(index == 2)
{

}
else if(index == 3)
{
	game_end(0);
}
else if(index == 4)
{
	room_goto(rm_title);
}
else if(index == 5)
{
	neat_server();
	room_goto(rm_lobby);
}
else if(index == 7)
{
	neat_stop();
	room_goto(rm_multiplayer);
}
else if(index == 8)
{
	if(global.neat.state == NetworkState.Server)
	{
		neat_send2_client("room", [rm_play], -1);
		room_goto(rm_play);
	}
}