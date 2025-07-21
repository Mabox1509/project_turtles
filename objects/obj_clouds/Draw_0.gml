draw_set_alpha(0.35);
shader_set(sh_clouds);

shader_set_uniform_f(uniform_time, current_time * 0.001);


var _x = (obj_camera.x * paralax) + x;
var _y = (obj_camera.y * paralax) + y;

draw_sprite_tiled(spr_clouds, 0, _x, _y);

shader_reset();
draw_set_alpha(1);