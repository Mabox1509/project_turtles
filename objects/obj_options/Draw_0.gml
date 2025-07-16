if(!surface_exists(obj_screen.canvas_surface))
	exit;

if(index < 0 || index >= array_length(options))
exit;

surface_set_target(obj_screen.canvas_surface);

//DRAW BASE
draw_self();

//DRAW TEXT
draw_set_color(c_white);
draw_text(x, y -10, label);

draw_set_color(c_gray);
draw_set_alpha(text_alpha * image_alpha);
draw_set_halign(fa_center);

draw_text(x + (image_xscale * 4), y + 2, options[index]);

draw_set_alpha(1);
draw_set_halign(fa_left);


surface_reset_target();