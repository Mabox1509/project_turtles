if(surface_exists(obj_screen.canvas_surface))
{
	surface_set_target(obj_screen.canvas_surface);
	
	if(surface_exists(surface))
	{
		//show_message("Drawing rect in canvas");
		draw_surface(surface, x, y);
	}
	

	
	surface_reset_target();
}
