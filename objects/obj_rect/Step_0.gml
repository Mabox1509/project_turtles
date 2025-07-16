if(can_scroll)
{
	var _dt = delta_time / 1000000;
	
	var _inn = mouse_wheel_up() - mouse_wheel_down();
	scroll += _inn * 512 * _dt;
	
	
	if(scroll < 0)
		scroll = scr_math_smooth(scroll, 0, 0.1);
		
	if(scroll > max_scroll)
		scroll = scr_math_smooth(scroll, max_scroll, 0.1);
		
	
	for(var _i = 0;_i < array_length(childs);_i++)
	{
		childs[_i].y = childs[_i].ystart + floor(scroll);
	}
}