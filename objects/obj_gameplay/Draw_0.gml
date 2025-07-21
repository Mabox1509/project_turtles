//[DRAW TILES]
var _coners = 
[
	floor(obj_camera.x / TILE_SIZE),
	floor(obj_camera.y / TILE_SIZE),
	
	floor((obj_camera.x + 192) / TILE_SIZE),
	floor((obj_camera.y + 192) / TILE_SIZE)

];

//DRAW SHADOWS
for(var _i = _coners[0]-1;_i <= _coners[2]+1;_i++)
{
	if(_i < 0 || _i >= MAP_SIZE)
		continue;
	
	for(var _j = _coners[1]-1;_j <= _coners[3]+1;_j++)
	{
		if(_j < 0 || _j >= MAP_SIZE)
			continue;
		
		
		var _tile = map_grid[# _i, _j];
		if(_tile == undefined)
			continue;
			
		_tile.on_draw_shade((_i * TILE_SIZE)-4, (_j * TILE_SIZE)+4);
	}
}


draw_set_alpha(1.0);
//DRAW TILES
for(var _i = _coners[0];_i <= _coners[2];_i++)
{
	if(_i < 0 || _i >= MAP_SIZE)
		continue;
	
	for(var _j = _coners[1];_j <= _coners[3];_j++)
	{
		if(_j < 0 || _j >= MAP_SIZE)
			continue;
		
		
		var _tile = map_grid[# _i, _j];
		if(_tile == undefined)
			continue;
			
		_tile.on_draw(_i * TILE_SIZE, _j * TILE_SIZE);
	}
}
