var _xcam = camera_get_view_x(view_camera[0]);
var _ycam =  camera_get_view_y(view_camera[0]);

if(surface_exists(canvas_surface))
{
	surface_set_target(canvas_surface);
	
	draw_set_color(c_black);
	draw_set_alpha(power(fade, 2));
	draw_rectangle(0, 0, 192, 192, false);
	
	
	var _time = (current_time * 0.001) * 8.5;
	var _xscale = 1 + (sin(_time) * 0.25);
	var _yscale = 1 + (cos(_time) * 0.25);
	
	draw_sprite_ext(spr_player, 0, 180, 180, _xscale, _yscale, _time * 35, c_white, draw_get_alpha());
	
	draw_set_alpha(1);
	
	surface_reset_target();
	
	draw_surface_ext(canvas_surface, _xcam, _ycam, TEXEL, TEXEL, 0, c_white, 1);
	
}

