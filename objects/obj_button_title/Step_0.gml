var _time = current_time / 1000;
var _sin = (sin(_time * pi) + 1) / 2;
_sin = floor(_sin / 0.25) * 0.25;

var _lerp = lerp(0.5, 1, _sin);

if(mouse_over)
{
	image_blend = merge_colour(c_black,#b07972, _lerp);
}
else
{
	image_blend = #b07972;
}

image_alpha = scr_math_smooth(image_alpha, mouse_over ? 1 : 0.75, 0.1);