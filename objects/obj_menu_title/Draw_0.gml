//Draw logo
draw_sprite(spr_logo, 0, 96, 16);

//Draw version
draw_set_color(c_white);
draw_set_alpha(0.5);
draw_text(2, 182, "ver: " + VERSION);