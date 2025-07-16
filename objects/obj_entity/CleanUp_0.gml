if(global.entities[? net_id] == id)
{
	ds_map_delete(global.entities, net_id);
}

if(instance_exists(shadow_inst))
{
	shadow_inst.target = noone;
	instance_destroy(shadow_inst);
}