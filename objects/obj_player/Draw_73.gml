// Inherit the parent event
event_inherited();


if(func_isowner())
{
	var _dist = point_distance(x, y, cursor.x, cursor.y);
	var _points = ceil(_dist / 12);
	
	draw_set_alpha(_dist < 12 ? 0.35 : 0.85);

	for(var _i = 1;_i <_points;_i++)
	{
		var _lerp = (_i / _points);
		
		var _xp = floor(lerp(x, cursor.x , _lerp));
		var _yp = floor(lerp(y, cursor.y , _lerp));
		
		draw_sprite(spr_target, 1, _xp, _yp);
	}
	draw_sprite(spr_target, 0, cursor.x, cursor.y);

	draw_set_alpha(1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	draw_set_alpha(0.5);
	draw_set_color(c_white);
	
	draw_text(x, y - 6, "you\n v ");
	
	draw_set_alpha(1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}