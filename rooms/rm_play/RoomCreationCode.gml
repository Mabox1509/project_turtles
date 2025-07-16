if(show_question("¿Quieres hostear?"))
{
	neat_server();
}
else
{
	var _ip = get_string("Ingresa la ip", "");
	var _port = real(get_string("Ingresa el puerto", string(DEFAULT_PORT)));
	
	if(!neat_client(_ip, _port))
	{
		show_error("No se pudo conectar );", true);
	}
}

//instance_create_depth(32, 32, 0, obj_player);