text_alpha = scr_math_smooth(text_alpha, 1, 0.1);

var _time = current_time / 1000;
var _sin = (sin(_time * 1.5) + 1) / 2;



if(active)
{
	left_inst.x = left_inst.xstart - floor(_sin * 3);
	rigth_inst.x = rigth_inst.xstart + floor(_sin * 3);
}
else
{
	left_inst.x = -1000;
	rigth_inst.x = -1000;
}