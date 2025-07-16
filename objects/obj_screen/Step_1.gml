if(frames_out > 0)
frames_out--;


if(frames_out <= 0)
{
	if(keyboard_check_pressed(vk_f4))
	{
		var _fullscreen = !window_get_fullscreen();
		window_set_fullscreen(_fullscreen);
		
		
		if(!_fullscreen)
		{
			scale = windowed_scale;
			window_set_size(RES * scale, RES * scale);
			window_center();
			
			
			offset[0] = 0;
			offset[1] = 0;
		}
		else
		{
			scale = fullscreen_scale;
			offset[0] = floor((display_get_width() - (RES * scale)) / 2);
			offset[1] = floor((display_get_height() - (RES * scale)) / 2);
		}
		
		surface_resize(application_surface, RES, RES);
		frames_out = 15;
		
		
	}
}




mouse_position[0] = device_mouse_raw_x(0) - offset[0];
mouse_position[0] /= scale;
mouse_position[0] = floor(mouse_position[0]);

mouse_position[1] = device_mouse_raw_y(0) - offset[1];
mouse_position[1] /= scale;
mouse_position[1] = floor(mouse_position[1]);



//[FADE]
var _dt = delta_time / 1000000;
fade = scr_math_towards(fade, global.screen_fade, 2.5 * _dt);