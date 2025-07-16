global.screen_fade = 0;
global.cursor_enable = true;

//[BUTTON]
inst_7728F884.x = ceil((inst_7728F884.text_size / 2) / 8) * 8;
inst_7728F884.y = 8;



inst_59BB0A99.label = scr_text("map_head");
inst_59BB0A99.options = 
[
	scr_text("map_0"),
	scr_text("map_1"),
	scr_text("map_2"),
	scr_text("map_3"),
	scr_text("map_4"),
];

inst_3DF190A7.label = scr_text("dificulty_head");
inst_3DF190A7.options = 
[
	scr_text("dificulty_0"),
	scr_text("dificulty_1"),
	scr_text("dificulty_2"),
	scr_text("dificulty_3"),
];


if(global.neat.state != NetworkState.Server)
{
	inst_59BB0A99.active = false;
	inst_3DF190A7.active = false;
	inst_65F6005.x = 10000;
}
else
{
	inst_65F6005.x = 190 - ceil((inst_65F6005.text_size / 2) / 8) * 8;
}

/*draw_set_font(fnt_ps2);
draw_set_alpha(0.5);
draw_set_color(c_white);

draw_text(2, 2, global.neat.ip + ":" + string(global.neat.port));


draw_set_alpha(1);
*/