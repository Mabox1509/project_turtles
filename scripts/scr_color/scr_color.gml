function scr_color_to_vec4(_color) {
    var r = ( (_color >> 16) & 0xFF ) / 255;
    var g = ( (_color >> 8)  & 0xFF ) / 255;
    var b = ( (_color      ) & 0xFF ) / 255;
    return [r, g, b, 1.0]; // Alpha fijo en 1.0
}