draw_sprite_ext(sprite_index, image_index, x-2, y+2, image_xscale, image_yscale, image_angle, c_black, 0.5 * image_alpha);
draw_self();



draw_set_font(fnt_ps2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _time = current_time * 0.001;      // segundos
_time += time_off;

if(!mouse_over)
{
	draw_set_color(c_black);
	draw_set_alpha(0.5);
	draw_text_transformed(x-2, y+2, text, 1, 1, sin(_time) * 5);
	
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_text_transformed(x, y, text, 1, 1, sin(_time) * 5);
}
else
{
	var x_cursor = x - ((text_size - 8) / 2);  
	draw_set_color(#4f868d);
	draw_set_alpha(1);
	for(var _i = 0;_i < string_length(text);_i++)
	{
	
		var _ch = string_char_at(text, _i+1);

	        var _dx = 0;
		var _dy = lerp
		(
			0, 
			sin((_time * 5) + (_i)) * 3,
			image_alpha
		);

	        //Dibuja el carácter
	        draw_text(x_cursor + _dx, y + _dy, _ch);

	        //Cursor
	        x_cursor += string_width(_ch);
	}
}


	
draw_set_halign(fa_left);
draw_set_valign(fa_top);