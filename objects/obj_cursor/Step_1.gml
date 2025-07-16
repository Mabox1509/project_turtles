//[DT]
var _dt = delta_time / 1000000;
//depth = -2000;

//[POSITION]
x = obj_screen.mouse_position[0];
y = obj_screen.mouse_position[1];

//[CHECK]
if (!global.cursor_enable)
    exit;

// Obtener todos los obj_rect bajo el mouse
var _count = collision_point_list(x, y, obj_rect, false, true, rect_list, false);
var _hit = noone;

if(_count > 0)
{
	for (var _i = 0; _i < _count; _i++)
	{
		var _rect = rect_list[| _i];
	
	
	        _hit = _rect.func_hit(x, y);

	        if (_hit != noone)
	        {
		            _hit.mouse_over = true;
			    _hit.on_over(x - _rect.x, y - _rect.y);
		
		            if (mouse_check_button_pressed(mb_left))
		            {
		                _hit.on_click();
		            }
		            break; // ya encontramos uno válido, salimos
	        }
	}
	ds_list_clear(rect_list);
}