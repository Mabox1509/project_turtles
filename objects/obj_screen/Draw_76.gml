if(!surface_exists(canvas_surface))
{
	canvas_surface = surface_create(VIEW, VIEW);
}

surface_set_target(canvas_surface);


	
draw_clear_alpha(c_black, 0);

surface_reset_target();

