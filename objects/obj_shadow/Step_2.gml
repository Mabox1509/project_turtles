if(target != noone)
{
	x = target.x - 2;
	y = target.y + 2;
	
	sprite_index = target.sprite_index;
	image_index = target.image_index;
	
	image_blend = c_black;
	image_alpha = 0.5;
	
	image_xscale = target.image_xscale;
	image_yscale = target.image_yscale;
	
	image_angle = target.visual_angle;
}