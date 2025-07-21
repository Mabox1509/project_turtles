event_inherited();

//[VARIABLES]
index = 0;
text = "";
text_size = 0;
time_off = random_range(-100, 100);

//[INIT]
if(room == rm_title)
{
	switch(y)
	{
		case 96:
			index = 0;
			text = scr_text("title_play");
	
		break;
	
		case 120:
			index = 1;
			text = scr_text("title_settings");
	
		break;
	
		case 144:
			index = 2;
			text = scr_text("title_about");
	
		break;
		
		case 176:
			index = 3;
			text = scr_text("title_exit");
	
		break;
	}
}
else if(room == rm_multiplayer)
{
	switch(y)
	{
		case 8:
			index = 4;
			text = scr_text("title_exit");
	
		break;
	
		case 32:
			index = 5;
			text = scr_text("online_create");
		break;
			
		case 48:
			index = 6;
			text = scr_text("online_direct");
		break;
	
	}
	
}
else if(room == rm_lobby)
{
	switch(y)
	{
		case 8:
			index = 7;
			text = scr_text("title_exit");
			
		break;
		
		case 176:
		
			index = 8;
			text = scr_text("online_start");
		
		break;
	}
}

draw_set_font(fnt_ps2);
text_size = string_width(text);

image_xscale = (text_size + 8) / 12;
image_alpha = 0;

on_click = function()
{
	obj_sounder.func_play_sfx(sfx_test);
	global.cursor_enable = false;
	
	
	if(index == 6)
	{
		inst_44D2F1EF.func_direct();
	}
	else if(index == 8)
	{
		if(global.neat.state == NetworkState.Server)
		{
			obj_menu_lobby.func_start();
		}
	}
	else
	{
		global.screen_fade = 1;
		alarm[0] = 30;
	}
}
on_over = function(_x, _y)
{

}