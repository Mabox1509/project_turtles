if(broadcast_socket >= 0)
{
	network_destroy(broadcast_socket);
}
ds_map_destroy(lan_servers);