var _xcam = camera_get_view_x(view_camera[0]);
var _ycam =  camera_get_view_y(view_camera[0]);

if(surface_exists(canvas_surface))
{

	
	draw_surface_ext(canvas_surface, _xcam, _ycam, TEXEL, TEXEL, 0, c_white, 1);
}

draw_set_color(c_black);
draw_set_alpha(power(fade, 2));
draw_rectangle(_xcam, _ycam, _xcam + 192, _ycam + 192, false);
draw_set_alpha(1);