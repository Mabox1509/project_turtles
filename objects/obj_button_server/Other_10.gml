draw_self();

draw_set_font(fnt_ps2);
draw_set_color(color_multiply(c_white, image_blend));
draw_text(x + 2, y + 2, motd);

draw_set_halign(fa_right);
draw_set_valign(fa_middle);

draw_text(x + 158, y + 12, string(players) + "/4");

draw_set_halign(fa_left);
draw_set_valign(fa_top);


draw_set_font(fnt_ops);
if(compatible)
{
	draw_set_color(color_multiply(c_gray, image_blend));
	draw_text(x + 2, y + 10, ip + ":" + string(port));
}
else
{
	draw_set_color(color_multiply(c_red, image_blend));
	draw_text(x + 2, y + 10, imcomp_text);
}