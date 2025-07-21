//CREATE TEMP
var _temp = array_create(MAP_SIZE);
for (var _x = 0; _x < MAP_SIZE; _x++)
{
	_temp[_x] = array_create(MAP_SIZE);
	for (var _y = 0; _y < MAP_SIZE; _y++)
	{
	    _temp[_x][_y] = func_getbuff(_x, _y);
	}
}


//Iterate
for (var _x = 0; _x < MAP_SIZE; _x++)
{
	for (var _y = 0; _y < MAP_SIZE; _y++)
	{
		var _val = func_getbuff(_x, _y);
		var _neighbors = 0;
		var _empty_neighbors = 0;
		
		var _neigths_pos = 
		[
			[_x+0 , _y-1], //UP
			[_x+0 , _y+1], //DOWN
			[_x-1 , _y+0], //LEFT
			[_x+1 , _y+0], //RIGTH
		];
		for(var _i = 0;_i < 4;_i++)
		{
			var _pos = _neigths_pos[_i];
			
			if(_pos[0] < 0 || _pos[0] >= MAP_SIZE)
				continue;
			
			if(_pos[1] < 0 || _pos[1] >= MAP_SIZE)
				continue;
				
			var _n = func_getbuff(_pos[0], _pos[1]);
			
			if(_n == 0x00)
			{
				_empty_neighbors++;
			}
			else if(_n == 0x01)
			{
				_neighbors++;
			}
		}
		

		// Lógica de escritura
		if (_val == 0x00 && _neighbors >= 2)
		{
			_temp[_x][_y] = 0x01;
		}
		else if (_val == 0x01)
		{
			var _perlin = scr_math_perlin(_x * PERLIN_DENSITY, _y * PERLIN_DENSITY, perlin_seed);

			
			if (_perlin > 0.5 && _empty_neighbors <= 0)
			{
				_temp[_x][_y] = 0x02;
			}
		}
	}
}


// Copia el buffer temporal de vuelta al original
for (var _x = 0; _x < MAP_SIZE; _x++)
{
	    for (var _y = 0; _y < MAP_SIZE; _y++)
	    {
	        func_setbuff(_x, _y, _temp[_x][_y]);
	    }
}

alarm[3] = 2;
