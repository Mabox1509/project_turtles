if(async_load[? "id"] != async_box_id)
	exit;

if(direct_state == 0)
{	
	if(async_load[? "status"])
	{
		connect_ip = async_load[? "result"];
		async_box_id = get_string_async(scr_text("online_port"), DEFAULT_PORT);
		direct_state = 1;
	}
	else
	{
		direct_state = -1;
		async_box_id  = -1;
		global.cursor_enable = true;
	}
}
else if(direct_state == 1)
{	
	if(async_load[? "status"])
	{
		connect_port = floor(real(async_load[? "result"]));
		
		func_connect();
		
	}
	else
	{
		direct_state = -1;
		async_box_id  = -1;
		global.cursor_enable = true;
	}
}