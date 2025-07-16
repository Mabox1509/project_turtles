if(!surface_exists(surface))
{
	surface = surface_create(size.x, size.y);
}


surface_set_target(surface);

//show_message("Clearing rect");
draw_clear_alpha(c_black, 0);

surface_reset_target();