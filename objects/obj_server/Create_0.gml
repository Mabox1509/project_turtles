//[VARIABLES]
clients = ds_map_create();
players_slots = array_create(4, false);
players_slots[0] = true;

broadcast_socket = network_create_socket(network_socket_udp);
server_motd = "Hola mundo";

neat_room = -1;
//show_message(broadcast_socket);

//[ALARM]
alarm[0] = 80;


//neat_spawn(16, 16, obj_player, 0);

//neat_spawn(floor(random_range(0, 192)), floor(random_range(0, 192)) , obj_enemy, 0);
