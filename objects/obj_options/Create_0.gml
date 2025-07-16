// Inherit the parent event
image_index = 3;
image_blend = c_gray;

//[EVENTS]
func_left = function()
{
	text_alpha = 0;
	index--;
	
	if(index < 0)
		index = array_length(options) - 1;
}
func_rigth = function()
{
	text_alpha = 0;
	
	index++;
	index %= array_length(options);
}


//[VARIABLES]
label = "label";
options = [ "Test0", "Test1", "idk" ];
index = 0;

left_inst = instance_create_depth(x-4, y+6, 0, obj_button);
left_inst.sprite_index = spr_ui_arrow;
left_inst.on_click = func_left;

rigth_inst = instance_create_depth(x+84, y+6, 0, obj_button);
rigth_inst.sprite_index = spr_ui_arrow;
rigth_inst.image_index = 1;
rigth_inst.on_click = func_rigth;

text_alpha = 1;
active = true;

//SCALE
image_xscale = 10;
image_yscale = 13/8;