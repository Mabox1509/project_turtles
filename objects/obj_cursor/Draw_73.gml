if(surface_exists(obj_screen.canvas_surface))
{
	surface_set_target(obj_screen.canvas_surface);
	
	draw_sprite_ext(sprite_index, image_index, x-2,y+2, image_xscale, image_yscale, image_angle, c_black, 0.75);
	draw_self();
	

	
	surface_reset_target();
}