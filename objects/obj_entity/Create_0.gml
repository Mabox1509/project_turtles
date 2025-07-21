#macro SYNC_RATE (1 / 50)

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

frict = 0;
dying = false;


visual_angle = 0;
bbox = [4, 4];


//[REFERENCES]
shadow_inst = instance_create_depth(x, y, depth, obj_shadow);
shadow_inst.target = id;

//[FUNCTIONS]
func_getbbox = function(_x, _y)
{
	return 
	[
		_x - bbox[0],
		_y - bbox[0],
		
		_x + bbox[0],
		_y + bbox[0]
	];
}
func_placemetting = function(_x, _y, _type)
{
	//GET BBOX
	var _bbox = func_getbbox(_x, _y);
	
	var _tbbox = 
	[
		floor(_bbox[0] / TILE_SIZE),
		floor(_bbox[1] / TILE_SIZE),
		floor(_bbox[2] / TILE_SIZE),
		floor(_bbox[3] / TILE_SIZE)
	];
	

	
	//CHECK TILES
	for (var _tx = _tbbox[0]; _tx <= _tbbox[2]; _tx++)
	{
		if (_tx < 0 || _tx >= MAP_SIZE)
			continue;
		
		for (var _ty = _tbbox[1]; _ty <= _tbbox[3]; _ty++)
		{
			if (_ty < 0 || _ty >= MAP_SIZE)
				continue;
			
			var _tile = obj_gameplay.map_grid[# _tx, _ty];

			if(_tile == undefined)
				continue;
				
				
			if(_tile.collision != _type)
				continue;
			
				
				
			var _localbbox = 
			[
				_bbox[0] - (_tx * TILE_SIZE),
				_bbox[1] - (_ty * TILE_SIZE),
				
				_bbox[2] - (_tx * TILE_SIZE),
				_bbox[3] - (_ty * TILE_SIZE),
			];
			if(_tile.is_colliding(id, _localbbox))
			{
				//_tile.frames[0] = floor(random_range(0, 6));
				//frames[1] = floor(random_range(0, 6));
				//_tile.frames[2] = floor(random_range(0, 6));
				//_tile.frames[3] = floor(random_range(0, 6));
				return _tile;
			}
		}
	}
	
	
	return noone;
}