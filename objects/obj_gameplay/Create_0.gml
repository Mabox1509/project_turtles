//[MACROS]
#macro MAP_SIZE 48
#macro TILE_SIZE 16

#macro PERLIN_DENSITY 0.1
#macro CORRIDOR_SIZE 2



//[VARS]
map_buffer = -1;
map_grid = ds_grid_create(MAP_SIZE, MAP_SIZE);
ds_grid_set_region(map_grid, 0, 0, MAP_SIZE-1, MAP_SIZE-1, undefined);


//[FUNCS]
func_getbuff = function(_x, _y)
{
	var _seek = (_y * MAP_SIZE) + _x;
	return buffer_peek(map_buffer,  _seek, buffer_u8);
}
func_setbuff = function(_x, _y , _val)
{
	var _seek = (_y * MAP_SIZE) + _x;
	buffer_poke(map_buffer,  _seek, buffer_u8, _val);
}
func_find_valid_spawn = function()
{
	var _tries = 1000; // prevenir loops infinitos

	while (_tries-- > 0)
	{
		var _x = irandom(MAP_SIZE - 1);
		var _y = irandom(MAP_SIZE - 1);
		var _tile = func_getbuff(_x, _y);

		if (_tile == 1 || _tile == 2)
		{
			var _px = _x * TILE_SIZE + TILE_SIZE / 2;
			var _py = _y * TILE_SIZE + TILE_SIZE / 2;
			return [_px, _py];
		}
	}

	return [0, 0]; // fallback si no encuentra nada
}
func_gentiles = function()
{
	for (var _x = 0; _x < MAP_SIZE; _x++)
	{
		for (var _y = 0; _y < MAP_SIZE; _y++)
		{
			var _id = func_getbuff(_x, _y);
			var _set = undefined;
		
			switch(_id)
			{
				case 0x00:
				break;
			
				case 0x01:
			
				_set = new TileGround(_x, _y);

				
			
				break;
			
				case 0x02:
			
				_set = new TileIce (_x, _y);
				
			
				break;
			
				default:
					show_message("A");
				break;
			}
		
			if(_set != undefined)
			_set.on_create(id);
		
			map_grid[# _x, _y] = _set;
		}
	}
}


//[INIT]
if(global.neat.state == NetworkState.Server)
{
	//GENERATE MAP
	sectors = [];
	
	sectors_2create = 30;
	sectors_created = 0;
	sectors_fail = 0;

	corridors_created = 0;
	corridors_2create = -1;
	
	perlin_seed = floor(random_range(0, 99999));
	
	map_buffer = buffer_create(power(MAP_SIZE, 2), buffer_fixed, 1);
	
	alarm[0] = 1;
}


depth = 100;