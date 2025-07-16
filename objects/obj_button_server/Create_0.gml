//[PARENT]
event_inherited();
imcomp_text = scr_text("online_incompatible");

//[VARS]
ip  = "";
port = "";

motd = "";
players = 1;

compatible = true;

//[OVERRIDE]
on_click = function()
{
	if(compatible)
	{
		global.cursor_enable = false;
	
		obj_menu_multiplayer.connect_ip = ip;
		obj_menu_multiplayer.connect_port = port;
		obj_menu_multiplayer.func_connect();
	}
	else
	{
		
	}
}