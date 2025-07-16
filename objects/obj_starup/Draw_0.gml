//Draw logo
var _channel = animcurve_get_channel(ac_logo, 0);
var _scale = animcurve_channel_evaluate(_channel, time) * 2;

draw_sprite_ext(spr_dreamdog, 0, 96, 96, _scale, _scale, 0, c_white, 1);