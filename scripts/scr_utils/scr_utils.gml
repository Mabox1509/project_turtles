function draw_text_shaded(_x, _y, _text, _color = c_white, _alpha = 1)
{
	draw_set_color(c_black);
	draw_set_alpha(0.5 * _alpha);
	
	draw_text(_x - 2, _y + 2, _text);
	
	draw_set_color(_color);
	draw_set_alpha(_alpha);
	
	draw_text(_x, _y, _text);
}

function color_multiply(_c1, _c2)
{
    var r1 = color_get_red(_c1) / 255;
    var g1 = color_get_green(_c1) / 255;
    var b1 = color_get_blue(_c1) / 255;

    var r2 = color_get_red(_c2) / 255;
    var g2 = color_get_green(_c2) / 255;
    var b2 = color_get_blue(_c2) / 255;

    var r = clamp(r1 * r2, 0, 1);
    var g = clamp(g1 * g2, 0, 1);
    var b = clamp(b1 * b2, 0, 1);

    return make_color_rgb(r * 255, g * 255, b * 255);
}