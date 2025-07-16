if(!instance_exists(parent))
	exit;

if(surface_exists(parent.surface))
{
	surface_set_target(parent.surface);
	//show_message("Drawind button in rect");	
	event_user(0);
	
	surface_reset_target();
}


mouse_over = false;