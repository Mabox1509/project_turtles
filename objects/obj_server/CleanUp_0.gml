if(global.neat.instance == id)
	global.neat.instance = noone;
	
network_destroy(broadcast_socket);
ds_map_destroy(clients);