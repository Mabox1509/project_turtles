//[CLEAR]
draw_clear(c_black);
var _layers = 
[
	[ #ff0000, 2 , 0], //Red
	[ #00ff00,  0 , -3], //Gren
	[ #0000ff, -1 , 0] //Blue
];

//SET SHADER
shader_set(sh_screen);
shader_set_uniform_f(time_uniform, current_time / 1000);
shader_set_uniform_f(resolution_uniform, (VIEW * scale) / 2);

//DRAW
gpu_set_blendmode(bm_add);

for(var _i = 0;_i < 3;_i++)
{
	var _x = offset[0]+ _layers[_i][1];
	var _y = offset[1] + _layers[_i][2];
	
	draw_surface_ext(application_surface, _x, _y, scale, scale, 0, _layers[_i][0], 1);
}

gpu_set_blendmode(bm_normal);
shader_reset();

