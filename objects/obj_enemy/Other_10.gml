var _dt = delta_time / 1000000;

var _target = collision_circle(x, y, view_radius, obj_player, false, true);
var _velx = 0;
var _vely = 0;

if(_target != noone)
{
	var _angle = point_direction(x, y, _target.x, _target.y);
	visual_angle = scr_math_smooth_angle(visual_angle, _angle-90, 0.1);
	
	var _rad = degtorad(_angle);
	
	_velx = cos(_rad) * spd;
	_vely = -sin(_rad) * spd;
}


vel_x = scr_math_towards(vel_x, _velx, (spd * accel) * _dt);
vel_y = scr_math_towards(vel_y, _vely, (spd * accel) * _dt);