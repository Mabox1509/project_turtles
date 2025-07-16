#macro SYNC_RATE (1 / 45)

//[NET]
if(!variable_global_exists("entities"))
{
	global.entities = ds_map_create();
	global.entities_count = 0;
}
net_id = -1;
owner = -1;
sync_timer = random_range(0, 0.25);
func_setid = function(_id = -1)
{
	if(_id < 0)
	{
		net_id = global.entities_count;
		global.entities[? net_id] = id;
		
		global.entities_count++;
	}
	else
	{
		net_id = _id;
		global.entities[? net_id] = id;
	}
};
func_isowner = function()
{
	return global.neat.session_id == owner;
}

//[MOVEMENTS]
vel_x = 0;
vel_y = 0;
sub_x = 0;
sub_y = 0;



visual_angle = 0;


//[REFERENCES]
shadow_inst = instance_create_depth(x, y, depth, obj_shadow);
shadow_inst.target = id;

//[FUNCTIONS]
