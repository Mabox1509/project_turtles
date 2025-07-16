//[VARIABLES]
size = {x : 8, y : 8};
surface = -1;
childs = [];
depth = 0;

can_scroll = false;
scroll = 0;
max_scroll = 0;

//[FUNCTION]
func_resize = function(_w, _h)
{
	size.x = _w;
	size.y = _h;
	
	if(surface_exists(surface))
		surface_free(surface);
		
	image_xscale  = _w / 8;
	image_yscale  = _h / 8;
}

func_hit = function(_mouse_x, _mouse_y)
{
	var _x = _mouse_x - x;
	var _y = _mouse_y - y;
	
	return collision_point(_x, _y, childs, false, true);
}