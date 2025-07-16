//[MACROS]
#macro VIEW 192
#macro TEXEL 1
#macro RES (VIEW*TEXEL)

if(!variable_global_exists("screen_instance"))
{
	global.screen_instance = id;
	global.screen_fade = 0;
}
else
{
	instance_destroy(id);
	exit;
}

//[VARIABLES]
canvas_surface = -1;

fullscreen_scale = floor((display_get_height() / RES));
windowed_scale =  fullscreen_scale - 1;

scale = windowed_scale;
offset = [0 , 0];


frames_out = 0;

mouse_position = [0 , 0];

time_uniform = shader_get_uniform(sh_screen, "time");
resolution_uniform = shader_get_uniform(sh_screen, "resolution");

fade = 1;

//INIT
window_set_size(RES * scale, RES * scale);
window_center();

surface_resize(application_surface, RES, RES);
application_surface_draw_enable(false);
depth = -1000;
window_set_cursor(cr_none);


//show_debug_overlay(true);
//alarm[0] = 1;