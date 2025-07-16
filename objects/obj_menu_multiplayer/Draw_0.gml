//Draw title
draw_set_font(fnt_ps2);
draw_set_halign(fa_right);

draw_text_shaded(190, 2, title_text, c_ltgray);

draw_set_font(fnt_ps2);
draw_set_halign(fa_left);


draw_sprite_stretched(spr_ui_box, 0, 8, 64, 176, 120);

if(surface_exists(lan_rect.surface))
{
	surface_set_target(lan_rect.surface);
	
	draw_set_font(fnt_ps2);
	draw_set_color(c_white);
	
	var _time = (current_time * 0.01) * 0.65;
	var _alpha = (sin(_time) + 1) / 2;
	draw_set_alpha(lerp(0.85, 1, _alpha));
	
	var _y = 26 * (ds_map_size(lan_servers));
	_y += lan_rect.scroll;

	draw_set_halign(fa_center);

	draw_text(85, _y, search_text);

	draw_set_halign(fa_left);


	surface_reset_target();
}

//170, 114