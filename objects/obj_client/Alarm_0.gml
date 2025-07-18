room_goto(neat_room);

neat_send2_server("room_loaded", [neat_room]);

neat_room  = -1;