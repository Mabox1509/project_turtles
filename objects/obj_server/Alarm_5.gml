if(global.neat.socket >= 0)
	network_destroy(global.neat.socket);


network_destroy(global.neat.socket);
instance_destroy(id);
global.neat.socket = -1;