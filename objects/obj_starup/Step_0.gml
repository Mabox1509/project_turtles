if(!started)
exit;

var _dt = delta_time / 1000000;

time += _dt;

if(time > 1.5 && !ended)
{
	ended = true;
	global.screen_fade = 1;
	alarm[1] = 30;
}

