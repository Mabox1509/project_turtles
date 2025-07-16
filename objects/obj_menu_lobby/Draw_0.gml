if(global.neat.state == NetworkState.Server)
{
	draw_set_font(fnt_ps2);
	
	draw_set_halign(fa_right);
	draw_text_shaded(190, 2,  "Port:" + string(global.neat.port), c_gray, 1);
	draw_set_halign(fa_left);
}
else
{
	
}

//DRAW PLAYERS
draw_set_color(c_white);
draw_text(2, 32, players_text);

for(var _i = 0;_i < 4;_i++)
{
	var _alpha = players[_i].connected ? 1 : 0.5;
	var _color = global.skin_colors[_i];
	
	var _y = 48 + (_i * 32);
	draw_sprite_stretched_ext(spr_ui_box, 1, 2, _y, 80, 12, _color, 0.75 * _alpha);
	
	draw_set_alpha(_alpha);
	draw_set_color(_color);
	
	var _pname = (_i == global.neat.player_index) ? you_text : "P" + string(_i + 1);
	draw_text(4, _y + 2, _pname + " - " + string(players[_i].ping) + "ms");
}
draw_set_alpha(1);
