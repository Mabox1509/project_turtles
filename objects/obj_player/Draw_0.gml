// Inherit the parent event
event_inherited();

if(surface_exists(obj_screen.canvas_surface))
{
	surface_set_target(obj_screen.canvas_surface);
	
	var _dt = delta_time / 1000000;
	var _ms = floor(_dt *1000);
	draw_text_shaded(2, 2, "FPS: " + string(fps) + "  ms: " + string(_ms));
	
	surface_reset_target()
}