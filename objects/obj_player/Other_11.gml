//[CAMERA]
var _camx = x - 96;
var _camy = y - 96;

if(!dying)
{
	if(inerpol_respawn)
	{
		obj_camera.x = scr_math_smooth(obj_camera.x, _camx, 0.1);
		obj_camera.y = scr_math_smooth(obj_camera.y, _camy, 0.1);
		
		if(point_distance(obj_camera.x, obj_camera.y, _camx, _camy) <= 2)
			inerpol_respawn = false;
	}
	else
	{
		obj_camera.x = _camx;
		obj_camera.y = _camy;
	}
}
else
{
	inerpol_respawn = true;
}


//[CURSOR]
cursor.x = obj_screen.mouse_position[0] + obj_camera.x;
cursor.y = obj_screen.mouse_position[1] + obj_camera.y;

