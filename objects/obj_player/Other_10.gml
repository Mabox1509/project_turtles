var _dt = delta_time / 1000000;
image_blend = global.skin_colors[global.neat.player_index];
depth = -5;



//[MOVE]
var _xinn =  keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _yinn =  keyboard_check(ord("S")) - keyboard_check(ord("W"));
if(abs(_xinn) +  abs(_yinn) > 1)
{
	_xinn /= norm;
	_yinn /= norm;
}

vel_x = scr_math_towards(vel_x, _xinn * spd,  spd * accel * _dt);
vel_y = scr_math_towards(vel_y, _yinn * spd,  spd * accel * _dt);



//[DIRECTION]
var _angle = floor(point_direction(x, y, cursor.x, cursor.y));
visual_angle = scr_math_smooth_angle(visual_angle, _angle - 90, 0.05);

